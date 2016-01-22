require 'pry'
require 'active_record'

ActiveRecord::Base.logger = Logger.new(STDERR) # shows log in console - for your own benefit, not for production

require './db_config'
require './models/dish'
require './models/dish_type'
require './models/user'
require './models/like'

binding.pry
