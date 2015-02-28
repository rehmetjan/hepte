class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :username
      t.string :name
      t.string :password_digest
      t.string :avatar
      t.text   :bio
      
      t.timestamps
    end
  end
end
