class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.string :auth_token
      t.boolean :dogs

      t.timestamps
    end
  end
end
