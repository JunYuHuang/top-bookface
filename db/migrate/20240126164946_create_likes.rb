class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes, primary_key: [:post_id, :liker_id] do |t|
      t.integer :post_id, null: false
      t.integer :liker_id, null: false

      t.timestamps
    end

    add_foreign_key :likes, :users, column: :liker_id
    add_index :likes, :liker_id
    add_foreign_key :likes, :posts, column: :post_id
    add_index :likes, :post_id
  end
end
