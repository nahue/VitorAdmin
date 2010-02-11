class CreateArticulos < ActiveRecord::Migration
  def self.up
    create_table :articulos do |t|
		t.text :texto
		t.integer :user_id
    	t.timestamps
    end
  end

  def self.down
    drop_table :articulos
  end
end
