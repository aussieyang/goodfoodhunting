# run to clear DB and add new dishes for testing

require './db_config'
require './models/dish'
require './models/dish_type'
require './models/user'
require './models/like'

# empty database every time, and...
DishType.delete_all
Dish.delete_all

#create three dish types and one dish
DishType.create(name: 'snack')
DishType.create(name: 'dessert')

brunch = DishType.create(name: 'brunch')

Dish.create(name: 'cakepudding', dish_type_id: brunch.id)

# DishType.map{ |dish_type| dish_type.id }
# DishType.pluck(:id)

10.times do |count|
  Dish.create(name: "dish-#{count}", img_url: "something")
end
