# APP CONTROLLER
require File.expand_path('../models/user_model', __FILE__)
require File.expand_path('../models/journal_model', __FILE__)
require File.expand_path('../models/entry_model', __FILE__)
require 'date'
require 'time'

# Creates a new user
test_user = User.new

# Adds a new journal named "Journal" to the user
test_user.add_journal(Journal.new('Jimbo'))
test_user.add_journal(Journal.new('Nigel'))
#puts test_user.inspect

test_journal = test_user.get_journal_by_name('Jimbo')
test_journal.name = 'Clark'
puts test_journal.name


test_journal.add_entry(Entry.new)
test_entry = test_journal.get_entry(1)
puts test_entry.inspect

test_entry.text = "This is the thing."
puts test_entry.text






