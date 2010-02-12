class Categoria < ActiveRecord::Base
	has_many :productos
    validates_uniqueness_of :nombre, :message => "No pueden existir dos categorias con el mismo nombre."
end
