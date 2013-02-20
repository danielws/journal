# USER MODEL 

class User
  attr_accessor :user_name, :password, :nickname, :journals

  def initialize
    @journals = Hash.new
  end

  def add_journal(obj)
    if @journals.length <= 10
      @journals[Journal.name] = obj
    else
      return nil
    end
  end

  def get_journal(string)
    return @journals[string]
  end
end
