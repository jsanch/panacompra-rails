class AddMoreFieldsToCompras < ActiveRecord::Migration
  def change
    add_column :compras, :compra_type, :string
    add_column :compras, :dependencia, :string
    add_column :compras, :nombre_contacto, :string
    add_column :compras, :telefono_contacto, :string
    add_column :compras, :correo_contacto, :string
    add_column :compras, :objeto, :string
    add_column :compras, :modalidad, :string
    add_column :compras, :unidad, :string
    add_column :compras, :provincia, :string
  end
end
