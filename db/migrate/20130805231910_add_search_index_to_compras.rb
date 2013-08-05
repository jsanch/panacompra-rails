class AddSearchIndexToCompras < ActiveRecord::Migration
  def up
    add_column :compras, :tsv_description, :tsvector
    execute "create index compras_description on compras using gin(tsv_description)"
    execute "UPDATE compras SET tsv_description = (to_tsvector('spanish', coalesce(description, '')))"
    execute <<-SQL
      CREATE TRIGGER tsvectorupdate BEFORE INSERT OR UPDATE
      ON compras FOR EACH ROW EXECUTE PROCEDURE
      tsvector_update_trigger(tsv_description, 'pg_catalog.spanish', description);
    SQL

    add_column :compras, :tsv_proponente, :tsvector
    execute "create index compras_proponente on compras using gin(tsv_proponente)"
    execute "UPDATE compras SET tsv_proponente = (to_tsvector('spanish', coalesce(proponente, '')))"
    execute <<-SQL
      CREATE TRIGGER tsvectorupdate1 BEFORE INSERT OR UPDATE
      ON compras FOR EACH ROW EXECUTE PROCEDURE
      tsvector_update_trigger(tsv_proponente, 'pg_catalog.spanish', proponente);
    SQL
  end

  def down
    remove_column :compras, :tsv_description
    remove_column :compras, :tsv_proponente
    execute "drop index compras_description"
    execute "drop index compras_proponente"
    execute "drop trigger tsvectorupdate on compras"
    execute "drop trigger tsvectorupdate1 on compras"
  end 
end
