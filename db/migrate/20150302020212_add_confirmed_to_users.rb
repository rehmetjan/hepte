class AddConfirmedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :confirmed, :boolean, default: false
    
    execute "CREATE UNIQUE INDEX index_users_on_lowercase_username ON users USING btree (lower(username))"
    execute "CREATE UNIQUE INDEX index_users_on_lowercase_email ON users USING btree (lower(email))"
  end
end
