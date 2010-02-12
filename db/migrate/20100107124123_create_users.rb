class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
	  t.string :username
      t.string :email
      t.string :crypted_password
      t.string :password_salt
      t.string :persistence_token
      
      t.timestamps
    end

=begin
User.create(
                :username => "admin",
                :email => "nahuel.chaves@gmail.com",
                :crypted_password => "cc15bd1c12f25e6d1712e0ee16ccb5247d65dad4f8522d8aa6a7307c89e293e53a9aaa95c24f9fb888e933757f240198000208619f188edb1139729a5b926363",
                :password_salt => "C187U0hGJm0JeHSj2p1e",
                :persistence_token => "a00d81b53bce5c013d4dd0de2e05d17c296699a734ef17d8c9a5d8e4edd18dc77b2052bf7fcd4533775491a570cf455200258246a1f8ddf5a10b3902144d6f59"
                )
=end
  end

  def self.down
    drop_table :users
  end
end
