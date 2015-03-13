class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.belongs_to :user, index: true
      t.belongs_to :category, index: true
      t.string :name
      t.string :author
      t.string :picture
      t.decimal :price
      t.string :isbn
      t.text :description
      t.decimal :rate
      t.float :hot, default: 0.0
      t.integer :comments_count, default: 0
      t.integer :likes_count, default: 0

      t.timestamps
    end
    
    add_index :books, :hot
  end
end
