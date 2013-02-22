# APP CONTROLLER
require File.expand_path('../models/user_model', __FILE__)
require File.expand_path('../models/journal_model', __FILE__)
require File.expand_path('../models/entry_model', __FILE__)
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

class View 
  def prompt
    print "> "
  end

  def main_menu
    puts "Welcome."
    puts "What would you like to do? Type:"
    puts "(1) to Log in"
    puts "(2) to Sign up"
    self.prompt
    return response = gets.chomp.to_i
  end

  def get_number 
    puts "-" * 80
    puts "Hello there, please enter your phone number."

    self.prompt
    return number = gets.chomp
  end

  def get_password(t_or_f)
    puts "-" * 80
    if t_or_f == true
      puts "Enter your password plz."
      self.prompt
      return password = gets.chomp
    else
      puts "Hey n00b. What do you want your password to be?"
      self.prompt
      return password = gets.chomp
    end
  end

end

class Controller
  attr_accessor :view, :db
  def start
    menu_response = @view.main_menu
    if menu_response = 1
      self.login
    elsif menu_response = 2
      self.signup
    end
  end

  def login 
    number = view.get_number
    if self.user_exist?(number)
      puts "we did it!"
    else
      puts "user doesn't exist."
    end
  end

  def signup
    view.get_number
  end

  def user_exist?(number) 
    if self.db.users.has_key?(number)
      return true
    else
      return false
    end
  end

end

# Start program
  controller = Controller.new
  controller.db = Database.new
  controller.view = View.new

controller.start


=begin
user_status = controller.user_exist?(db, view.get_number) 
puts user_status.inspect

password = view.get_password(user_status)
puts password.inspect


# need some sort of state machine runner script down here.
=end


