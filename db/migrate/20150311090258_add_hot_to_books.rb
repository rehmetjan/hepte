class AddHotToBooks < ActiveRecord::Migration
  def change
    add_column :books, :hot, :float, default: 0.0
  end
end
