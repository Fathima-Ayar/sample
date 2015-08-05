class AddForeignKeyToArticles < ActiveRecord::Migration
  def change
  end
 add_foreign_key :articles, :users

end
