# VIEW

class View 
  def prompt
    print "> "
  end

  def line
    puts "-" * 80
  end

  def new_view_line
    puts "=" * 80
  end

  def alert_line
    puts "*" * 80
  end

  def get_input
    self.line
    self.prompt
    return number = gets.chomp
  end

  def puts_string(string)
    puts string
  end
  
  def logged_out 
    self.new_view_line
    puts "What would you like to do? Type:"
    puts "(1) to Log in"
    puts "(2) to Sign up"
    self.prompt
    return response = gets.chomp.to_i
  end

  def main_menu 
    self.new_view_line
    puts "What would you like to do? Type:"
    puts "(1) to select a Journal"
    puts "(2) to create a Journal"
    puts "(3) to Log out"
    self.prompt
    return response = gets.chomp.to_i
  end

  def puts_list(obj)
    puts obj.name
  end

  def journal_menu(obj)
    self.new_view_line
    journal_name = obj.name
    puts "Currently viewing: #{journal_name}"
    puts "Type a date to view entries for that day."
    puts "Type '+' to create an entry."
    self.prompt
    return input = gets.chomp
  end

  def show_results(obj)
    self.new_view_line
    obj.each do |x|
      puts x.time
      puts x.text
      self.line
    end
  end

  # Error messages
  def show_error(string)
    self.alert_line
    case string 

    # Menu ------------------------------------------- 
    when 'invalid'
      puts "invalid input. Please try again."

    when 'no-journal-found'
      puts "No journal found by that name."

    when 'no-results'
      puts "No results found."

    # Sign up ------------------------------------------- 
    when 'username-taken' 
      puts "That username is taken."
    
    when 'password-missmatch'
      puts "Your passwords didn't match. Try again."

    # Log in ------------------------------------------- 
    when 'password-incorrect'
      puts "Password incorrect"
    
    when 'username-incorrect'
      puts "Username incorrect"
    end
    self.alert_line
  end

  # Messages
  def show_message(string)
    self.line
    case string 
    
    # Main menu ------------------------------------------- 
    when 'greeting'
      puts "Hello there!"

    when 'journal-name'
      puts "What do you want to name your Journal?"

    when 'journal-added'
      puts "Journal added."

    when 'your-journals'
      puts "Your Journals: Type its name to select it."
    when 'entry-input'
      puts "Type your entry."

    when 'entry-added'
      print "Your entry was added @ "

    when 'search-date'
      puts "Type a date to see entries on that day."

    # Log in ------------------------------------------- 
    when 'get-number'
      puts "Please enter your phone number."

    when 'get-password'
      puts "Enter your password."

    when 'logged-in'
      puts "You're in."

    # Sign up ------------------------------------------- 
    when 'account-created' 
      puts "Account created. Enter credentials to log in."
      self.new_view_line

    when 'set-password' 
      puts "What would you like your password to be?"

    when 'confirm-password'
      puts "Type your password again to confirm."

    # Sign up ------------------------------------------- 
    when 'log-out'
      puts "Logged you out."
    end
  end
end

