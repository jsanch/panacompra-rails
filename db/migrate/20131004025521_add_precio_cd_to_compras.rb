class AddPrecioCdToCompras < ActiveRecord::Migration
  def change
    add_column :compras, :precio_cd, :decimal, :precision => 8, :scale => 2
  end
end
