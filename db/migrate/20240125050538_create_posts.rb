class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.integer :author_id, null: false
      t.text :body, null: false

      t.timestamps
    end

    add_foreign_key :posts, :users, column: :author_id
    add_index :posts, :author_id
  end
end
