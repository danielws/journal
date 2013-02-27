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
  attr_accessor :view, :db, :logged_in, :current_user, :current_journal

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
      elsif menu_response == 1
        self.explore_journal(self.select_journal)
      else
        view.show_error('invalid')
      end
    end
  end

  def current_date_time
    return DateTime.now
  end

  def format_time
    t = self.current_date_time.strftime("%l:%M %p")
    return t
  end

  def format_date
    d = self.current_date_time.strftime("%B %Y")
    return d
  end
  
  def add_journal
    view.show_message('journal-name')
    journal_name = @view.get_input
    journal_added = @current_user.add_journal(Journal.new(journal_name))
    view.show_message('journal-added')
    puts journal_added.inspect
  end

  def select_journal
    @view.show_message('your-journals')
    @current_user.journals.each_value do |journal|    
      @view.puts_list(journal)
    end
    input = @view.get_input
    journal = @current_user.get_journal_by_name(input) 

    if journal == nil 
      @view.show_error('no-journal-found')
      self.select_journal
    else
      return journal
    end
  end

  def explore_journal(journal)
    self.current_journal = journal
    response = @view.journal_menu(@current_journal)
    if response == '+'
      self.add_journal_entry
    else
      self.display_journal_entries(response)
    end
  end

  def add_journal_entry
      entry = Entry.new 
      @view.show_message('entry-input')
      entry.text = @view.get_input
      entry.date = self.format_date
      entry.time = self.format_time
      @current_journal.add_entry(entry)
      @view.show_message('entry-added')
      @view.puts_string(entry.time)
      self.explore_journal(@current_journal)
  end

  def display_journal_entries(string)
      search = string
      array = @current_journal.get_entries_by_date(search)
      if array.empty?
        @view.show_error('no-results')
        self.display_journal_entries
      else
        @view.show_results(array)
        self.explore_journal(@current_journal)
      end
  end

  def logout
    view.show_message('log-out')
    @current_user = nil
    self.start
  end

  def login 
    @view.show_message('get-number')
    number = @view.get_input
    @view.show_message('get-password')
    password = @view.get_input
    self.auth(number, password)
  end

  def sign_up
    @view.show_message('get-number')
    number = @view.get_input

    # Check to see if the username is taken.
    if user_exist?(number)
      @view.show_error('username-taken')
      return self.sign_up

    # Grab the password. 
    else
      @view.show_message('set-password')
      password = @view.get_input
      @view.show_message('confirm-password')
      password_2 = @view.get_input

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


