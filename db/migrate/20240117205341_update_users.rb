class UpdateUsers < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :username, :string, null: false, default: ""
    add_index :users, :username, unique: true
  end
end
