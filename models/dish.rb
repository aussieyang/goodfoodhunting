class Dish < ActiveRecord::Base
  #one to many associations
  belongs_to :dish_type #points to dish type singular convention
  has_many :likes

  validates :name, presence: true #does not allow save if name blank
  validates :name, length: { minimum: 2 }
end

#can use .errors or .errors.full_messages method to display the error message
