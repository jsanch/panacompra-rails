class ChangePrecisionForPrecio < ActiveRecord::Migration

  def self.up
    change_table :compras do |t|
      t.change :precio_cd, :decimal, :precision => 16, :scale => 2
      t.change :precio, :decimal, :precision => 16, :scale => 2
    end
  end
  def self.down
    change_table :compras do |t|
      t.change :precio_cd, :decimal, :precision => 16, :scale => 2
      t.change :precio, :decimal, :precision => 16, :scale => 2
    end
  end

end
