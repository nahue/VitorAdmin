class Admin::CategoriasController < Admin::AdminController
	load_and_authorize_resource
	ActiveRecord::Base.include_root_in_json = false

	def index
		@categorias = Categoria.all
		if (params[:_dc])
			render :json => {:success => true, :message => "Categorias cargadas correctamente.", :datos => @categorias}
		end
	end
	
	def edit
	end
	
	def update
	    @categoria = Categoria.find(params[:id])
	    if @categoria.update_attributes(params[:categoria])
	      flash[:notice] = "Categoria modificada."
	      redirect_to categorias_path
	    else
	      flash[:notice] = "No se pudo modificar la categoria."
	    end
	end
	
	def new
		@categoria = Categoria.new
	end
	
	def create
	  	if @categoria.save
	  		flash[:notice] = "Categoria guardada correctamente."
	  		redirect_to root_url
	  	else
	  		flash[:notice] = "Ocurrio un error."
	  		render :action => 'new'  
	  	end
	end
	
	def destroy
		@categoria = Categoria.find(params[:id])
		if @categoria.destroy
			render :json => {:success => true, :message => "Categoria eliminada."}
		else
			render :json => { :message => "Hubo un error." }
		end
	end
end
