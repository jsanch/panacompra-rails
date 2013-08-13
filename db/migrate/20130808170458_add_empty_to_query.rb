class AddEmptyToQuery < ActiveRecord::Migration
  def change
    add_column :queries, :empty, :boolean, default: false
  end
end
