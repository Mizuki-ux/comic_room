class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|
      t.integer :user_id
      t.integer :post_id
      t.integer :product_id

      t.timestamps
    end
  end
end
