class CreateFollowRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :follow_requests do |t|
      t.integer :requestee_id, null: false
      t.integer :requester_id, null: false

      t.timestamps
    end

    add_foreign_key :follow_requests, :users, column: :requestee_id
    add_foreign_key :follow_requests, :users, column: :requester_id
    add_index :follow_requests, [:requestee_id, :requester_id], unique: true
  end
end
