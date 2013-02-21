# JOURNAL MODEL 

class Journal
  attr_accessor :name, :entries, :journal_id 
  
  def initialize(string)
    @entries = Hash.new
    @name = string
  end

  def add_entry(obj)
    obj.journal = self
    obj.entry_id = @entries.length + 1
    @entries[obj.entry_id] = obj
  end

  def get_entry(key)
    return @entries[key]
  end
  
  def get_entry_by_date(string)
    @entries.each_value do |x|
      if x.date == string
        return x
      end
    end
    return nil
  end
end

