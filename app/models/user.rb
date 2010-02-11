class User < ActiveRecord::Base
	has_and_belongs_to_many :grupos
	has_many :articulos
	
	acts_as_authentic  


  def usuario_actual
    UserSession.find.record
  end
  
  def roles
    listado_roles = Array.new
    
    usuario_actual.grupos.each do |rol|
      listado_roles << rol.nombre
    end
    return listado_roles
  end
  
  def role? (rol = nil)
    roles.include? rol.to_s if UserSession.find

  end
  
end
