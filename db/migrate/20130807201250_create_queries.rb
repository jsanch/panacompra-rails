class CreateQueries < ActiveRecord::Migration
  def change
    create_table :queries do |t|
      t.string :query
      t.string :entidad
      t.integer :price_min
      t.integer :price_max

      t.timestamps
    end
  end
end
