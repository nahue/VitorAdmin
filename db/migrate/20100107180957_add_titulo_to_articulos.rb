class AddTituloToArticulos < ActiveRecord::Migration
  def self.up
    add_column :articulos, :titulo, :string
  end

  def self.down
    remove_column :articulos, :titulo
  end
end
