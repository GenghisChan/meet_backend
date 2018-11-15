class CreateConversations < ActiveRecord::Migration[5.2]
  def change
    create_table :conversations do |t|
      t.string :title
      # t.integer :follower_id
      # t.integer :followed_id

      t.timestamps
    end
  end
end
