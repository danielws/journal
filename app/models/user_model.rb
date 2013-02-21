# USER MODEL 

class User
  attr_accessor :user_name, :password, :nickname, :journals

  def initialize
    @journals = Hash.new
  end

  def add_journal(obj)
    if @journals.length <= 10
      obj.journal_id = @journals.length + 1
      @journals[obj.journal_id] = obj
    else
      return nil
    end
  end

  def get_journal(key)
    return @journals[key]
  end

  # Finder method
  def get_journal_by_name(string)
    @journals.each_value do |x|
      if x.name == string
        return x
      end
    end
    return nil
  end
end
