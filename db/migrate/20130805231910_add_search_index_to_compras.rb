class AddSearchIndexToCompras < ActiveRecord::Migration
  def up
    add_column :compras, :tsv_description, :tsvector
    execute "create index compras_description on compras using gin(tsv_description)"
    execute "UPDATE compras SET tsv_description = (to_tsvector('spanish', coalesce(description, '')) || to_tsvector('spanish', coalesc(proponente, '')))"
    execute <<-SQL
      CREATE TRIGGER tsvectorupdate BEFORE INSERT OR UPDATE
      ON compras FOR EACH ROW EXECUTE PROCEDURE
      tsvector_update_trigger(tsv_description, 'pg_catalog.spanish', description, proponente);
    SQL
  end

  def down
    remove_column :compras, :tsv_description
#    execute "drop index compras_description"
    execute "drop trigger tsvectorupdate on compras"
  end 
end
