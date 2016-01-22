# ActiveRecord does what objects_example.rb does for you
require 'active_record'
require 'pry'

# connect ActiveRecord to database
options = {
  adapter: 'postgresql',
  database: 'goodfoodhunting'
}

ActiveRecord::Base.establish_connection(options)

# method that maps dishes table to Dish class
## MUST follow convention underscores and plural for table name and camelcase singular for class
class Dish < ActiveRecord::Base
  # creates relationship with dishtype
  belongs_to :dish_type
  # refers to the Dishtype class
end

class DishType < ActiveRecord::Base
  # corresponds to belongs_to above
  has_many :dishes
  # refers to Dish class but uses plural
end

binding.pry

# a = Dish.new
## assign all the properties
# a.save    ## this saves the new object into your database
