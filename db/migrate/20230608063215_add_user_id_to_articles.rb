class AddUserIdToArticles < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :userid, :int
  end
end
