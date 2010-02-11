class TiposController < ApplicationController
	load_and_authorize_resource
	  ActiveRecord::Base.include_root_in_json = false

	def index
		@tipos = Tipo.all
		respond_to do |format|
			format.html
			format.json { render :json => { :tipos => @tipos } }
		end			

	end
	
	def edit
	end
end
