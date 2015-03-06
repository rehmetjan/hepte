class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.belongs_to :user, index: true
      t.reference :commentable, polymorphic: true, index: true
      t.text :body
      t.integer :likes_count
      t.boolean :trashed, default: false

      t.timestamps
    end
  end
end
