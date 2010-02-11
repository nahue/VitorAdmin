class Categoria < ActiveRecord::Base
	has_many :productos
	has_and_belongs_to_many :tipos
end
