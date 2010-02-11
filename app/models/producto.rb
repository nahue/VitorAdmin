class Producto < ActiveRecord::Base
	belongs_to :categoria
	has_attached_file :imagen, :styles => {:medium => "300x300>", :thumb => "100x100>"}
end
