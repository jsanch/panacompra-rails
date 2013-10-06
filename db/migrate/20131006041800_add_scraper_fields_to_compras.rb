class AddScraperFieldsToCompras < ActiveRecord::Migration
  def change
    add_column :compras, :parsed, :boolean, default: false
    add_column :compras, :visited, :boolean, default: false
    add_column :compras, :html, :text
  end
end
