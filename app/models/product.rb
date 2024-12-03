class Product < ApplicationRecord
  with_options presence: true do
   validates :name
   validates :description
   validates :image
 end
 has_one_attached :image
 has_many :posts
 
 def self.looks(search, word)
    if search == "perfect"
      @product = Product.where("name LIKE?", "#{word}")
    elsif search == "forward"
      @product = Product.where("name LIKE?","#{word}%")
    elsif search == "backward"
      @product = Product.where("name LIKE?","%#{word}")
    elsif search == "partial"
      @product = Product.where("name LIKE?","%#{word}%")
    else
      @product = Product.all
    end
 end 
end
