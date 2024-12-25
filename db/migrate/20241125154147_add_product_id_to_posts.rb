class AddProductIdToPosts < ActiveRecord::Migration[6.1]
  def change
    add_reference :posts, :product
  end
end
