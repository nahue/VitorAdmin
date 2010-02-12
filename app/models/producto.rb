class Producto < ActiveRecord::Base
	belongs_to :categoria
    belongs_to :operacion
    validates_presence_of :categoria_id, :operacion_id, :modelo, :detalle, :precio 
	has_attached_file :imagen, :styles => {:medium => "300x300>", :thumb => "100x100>"}
end
