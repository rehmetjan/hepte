class AddLockedToBook < ActiveRecord::Migration
  def change
    add_column :books, :locked, :boolean, default: true
  end
end
