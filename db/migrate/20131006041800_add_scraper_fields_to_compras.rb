class AddScraperFieldsToCompras < ActiveRecord::Migration
  def change
    add_column :compras, :parsed, :boolean
    add_column :compras, :visited, :boolean
    add_column :compras, :html, :text
  end
end
