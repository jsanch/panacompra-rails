class AddDoneToCompras < ActiveRecord::Migration
  def change
    add_column :compras, :done, :boolean
  end
end
