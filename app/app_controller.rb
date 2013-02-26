# APP CONTROLLER
require File.expand_path('../models/user_model', __FILE__)
require File.expand_path('../models/journal_model', __FILE__)
require File.expand_path('../models/entry_model', __FILE__)
require File.expand_path('../views/view', __FILE__)
require 'date'
require 'time'


class Database
  attr_accessor :users

  def initialize
    @users = Hash.new
  end
 
  # Create a new user in the database. Pass in a phone number for a key.
  def add_user(number)
    user = User.new
    user.user_name = number
    @users[user.user_name] = user
  end

  def get_user(key)
    return @users[key]
  end
end

class Controller
  attr_accessor :view, :db, :logged_in, :current_user

  def start
    self.logged_in = false
    @view.show_message('greeting')

    until @logged_in == true
      menu_response = @view.logged_out
      if menu_response == 1
        self.login
      elsif menu_response == 2
        self.sign_up
      else
        view.show_error('invalid')
      end
    end

    until @logged_in == false
      menu_response = @view.main_menu
      if menu_response == 3
        self.logout
      elsif menu_response == 2
        self.add_journal
      else
        view.show_error('invalid')
      end
    end
  end
  
  def add_journal
    view.show_message('journal-name')
    journal_name = @view.get_journal_name
    journal_added = @current_user.add_journal(Journal.new(journal_name))
    view.show_message('journal-added')
    puts journal_added.inspect
  end

  def logout
    view.show_message('log-out')
    @current_user = nil
    self.start
  end

  def login 
    @view.show_message('get-number')
    number = @view.get_number
    @view.show_message('get-password')
    password = @view.get_password
    self.auth(number, password)
  end

  def sign_up
    @view.show_message('get-number')
    number = @view.get_number

    # Check to see if the username is taken.
    if user_exist?(number)
      @view.show_error('username-taken')
      return self.sign_up

    # Grab the password. 
    else
      @view.show_message('set-password')
      password = @view.get_password
      @view.show_message('confirm-password')
      password_2 = @view.get_password

      if password_2 == password
        @db.add_user(number)
        user = @db.get_user(number)
        user.password = password_2
        @view.show_message('account-created')
        return self.login

      else
        @view.show_error('password-missmatch')
        self.sign_up
      end
    end
  end

  def user_exist?(number) 
    if @db.users.has_key?(number)
      return true
    else
      return false
    end
  end

  def auth(num, pw)
    if self.user_exist?(num)
      user = @db.get_user(num)
      if pw == user.password
        @view.show_message('logged-in')
        @current_user = user
        self.logged_in = true
      else 
        puts "password incorrect"
        @view.show_error('password-incorrect')
      end
    else
      puts "username incorrect"
      @view.show_error('username-incorrect')
    end
  end
end

# Start program
  controller = Controller.new
  controller.db = Database.new
  controller.view = View.new

controller.start


