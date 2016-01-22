require 'pry'
require 'pg'

def run_sql(sql)
  db = PG.connect(dbname: 'goodfoodhunting')
  results = db.exec(sql)
  db.close
  return results
end

class Dish

  def initializer(id, name, image_url, dish_type_id)
    attr_accessor :id, :name, :image_url, :dish_type_id

    @id = id
    @name = name
    @image_url = image_url
    @dish_type_id = dish_type_id
  end

end

# translates data to objects instead of simple hashes
# this translates tables into a class and a record to an object

records = run sql('SELECT * FROM dishes;')

dishes = records.map do |record|
  Dish.new(record['id'], record['name'], record['image_url'])
end

binding.pry

# dishes = []
#
# dishes.each do |dish|
#   puts dish.name
#   puts dish.dish_type.name
# end
