class CreateAlerts < ActiveRecord::Migration
  def change
    create_table :alerts do |t|
      t.string :entidad
      t.string :descripcion
      t.integer :precio_min
      t.integer :precio_max

      t.timestamps
    end
  end
end
