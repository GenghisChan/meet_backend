class CreateRelationships < ActiveRecord::Migration[5.2]

  def change
    create_table :relationships do |t|
      t.integer :follower_id
      t.integer :followed_id
      t.boolean :follower_answer
      t.boolean :followed_answer, default: true
      t.string :status, default: 'pending'

      t.timestamps
    end
    add_index :relationships, :follower_id
    add_index :relationships, :followed_id
    add_index :relationships, [:follower_id, :followed_id], unique: true
  end
end
