class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :post
  belongs_to :product
  
  validates :user_id, uniqueness: {scope: :post_id}
end
