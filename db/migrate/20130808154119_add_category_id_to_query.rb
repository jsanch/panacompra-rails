class AddCategoryIdToQuery < ActiveRecord::Migration
  def change
    add_column :queries, :category_id, :integer
  end
end
