class DishType < ActiveRecord::Base
  has_many :dishes  #points to Dish table but plural convention
end
