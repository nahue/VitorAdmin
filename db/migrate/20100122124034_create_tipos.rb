class CreateTipos < ActiveRecord::Migration
  def self.up
    create_table :tipos do |t|
      t.string :nombre

      t.timestamps
    end
    Tipo.create :nombre => "Venta"
    Tipo.create :nombre => "Alquiler"
  end

  def self.down
    drop_table :tipos
  end
end
