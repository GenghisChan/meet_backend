class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.integer :age
      t.string :sex
      t.string :location
      t.text :bio
      t.string :img_url
      t.boolean :dogs, default: false
      t.boolean :online, default: false

      t.timestamps
    end
  end
end
