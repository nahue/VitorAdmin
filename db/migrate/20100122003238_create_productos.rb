class CreateProductos < ActiveRecord::Migration
  def self.up
    create_table :productos do |t|
		t.string :modelo
		t.text :detalle
		t.integer :precio
		t.string :imagen
		t.integer :borrado
        t.references :categoria
        t.references :operacion
      t.timestamps
    end
  end

  def self.down
    drop_table :productos
  end
end
