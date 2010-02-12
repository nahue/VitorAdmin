class Ability  
include CanCan::Ability  
  
  def initialize(user) 
  	user ||= User.new # Guest user  
  	can :read, :all
  	can :create, User
  	cannot :read, [User, Articulo, Categoria, Producto]
    if user.role? :Administradores
      can :manage, :all
    end
    if user.role? :Moderador
      can :update, Articulo
    end
  	#can :read, [Articulo, User]
  	#can :create, Articulo
  	#can :destroy, Articulo
  end  
end  