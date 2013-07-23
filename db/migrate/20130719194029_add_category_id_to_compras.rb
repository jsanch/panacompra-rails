class AddCategoryIdToCompras < ActiveRecord::Migration
  def change
    add_column :compras, :category_id, :integer
  end
end
