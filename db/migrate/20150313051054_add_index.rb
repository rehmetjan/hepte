class AddIndex < ActiveRecord::Migration
  def change
    execute "CREATE UNIQUE INDEX index_users_on_lowercase_username ON users USING btree (lower(username))"
    execute "CREATE UNIQUE INDEX index_users_on_lowercase_email ON users USING btree (lower(email))"
    execute "CREATE UNIQUE INDEX index_categories_on_lowercase_slug ON categories USING btree (lower(slug))"
  end
end
