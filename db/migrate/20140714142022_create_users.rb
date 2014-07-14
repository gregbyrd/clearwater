class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :firstname
      t.string :lastname
      t.string :email
      t.string :phone
      t.string :password_digest
      t.integer :purchased
      t.text :guests
      t.boolean :admin

      t.timestamps
    end
  end
end
