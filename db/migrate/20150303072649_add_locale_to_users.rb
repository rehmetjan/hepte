class AddLocaleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :locale, :string
    add_column :users, :locked_at, :string
  end
end
