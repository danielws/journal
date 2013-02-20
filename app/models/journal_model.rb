# JOURNAL MODEL 

class Journal
  attr_accessor :name, :entries 
  
  def initialize
    @entries = Hash.new
  end

  def add_entry(obj)
    obj.journal = self
    @entries[obj.entry_id] = obj
  end

  def get_entry(int)
    return @entries[int]
  end
end
