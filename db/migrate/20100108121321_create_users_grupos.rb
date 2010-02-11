class CreateUsersGrupos < ActiveRecord::Migration
  def self.up
  	create_table :grupos_users do |t|
  		t.integer :user_id
  		t.integer :grupo_id
  	end
  end

  def self.down
  	drop_table :grupos_users
  end
end
