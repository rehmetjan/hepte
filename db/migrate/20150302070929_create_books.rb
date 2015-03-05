class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :name
      t.string :author
      t.string :picture
      t.decimal :price
      t.string :isbn
      t.text :description
      t.decimal :rate

      t.timestamps
    end
  end
end
