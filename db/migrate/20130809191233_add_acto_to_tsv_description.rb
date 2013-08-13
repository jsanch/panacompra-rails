class AddActoToTsvDescription < ActiveRecord::Migration
  def up
    execute "drop index compras_description"
    execute "UPDATE compras SET tsv_description = (to_tsvector('spanish', coalesce(description, '')) || to_tsvector('spanish', coalesce(proponente, '')) || to_tsvector('spanish',coalesce(acto,'')) )"
    execute "CREATE TRIGGER tsvectorupdate BEFORE INSERT OR UPDATE ON compras FOR EACH ROW EXECUTE PROCEDURE tsvector_update_trigger(tsv_description, 'pg_catalog.spanish', description, proponente, acto);"
    execute "create index compras_description on compras using gin(tsv_description)"
  end

  def down
    execute "drop index compras_description"
    execute "drop trigger tsvectorupdate on compras"
  end 

end
