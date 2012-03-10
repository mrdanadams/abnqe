class AddNetflixInfoToUser < ActiveRecord::Migration
  def change
    add_column :users, :netflix_info, :text
    add_column :users, :netflix_id, :string
  end
end
