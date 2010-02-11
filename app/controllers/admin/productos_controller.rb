class Admin::ProductosController < Admin::AdminController
	load_and_authorize_resource
	ActiveRecord::Base.include_root_in_json = false
  	uses_tiny_mce :options => {
  					:language => 'es',
                    :theme => 'advanced',
                    :theme_advanced_resizing => true,
                    :theme_advanced_resize_horizontal => false,
                    :plugins => %w{ table fullscreen }
                   }
  
	def index
		@productos = Producto.all
		@cantidad_productos = Producto.count
		if (params[:_dc])
			@productos = Producto.all(:limit => params[:limit], :offset => params[:start] )
			render :json => {:total => @cantidad_productos, :success => true,:datos => @productos}
		end

	end
	
	def edit
		@producto = Producto.find(params[:id])
	end
	
	def update
	    @productos = Producto.find(params[:id])
	    if @productos.update_attributes(params[:producto])
	      flash[:notice] = "Producto modificado."
	      redirect_to admin_productos_path
	    else
	      flash[:notice] = "No se pudo modificar el producto."
	    end
	end
	
	def new
		@producto = Producto.new
	end
	
	def create
		@producto = Producto.create(params[:producto])
	  	if @producto.save
	  		flash[:notice] = "Producto guardado correctamente."
	  		redirect_to admin_productos_url
	  	else
	  		flash[:notice] = "Ocurrio un error."
	  		render :action => 'new'  
	  	end
	end
	
	def destroy
		@producto = Producto.find(params[:id])
		if @producto.destroy
			render :json => {:success => true, :message => "Producto eliminado."}
		else
			render :json => { :message => "Hubo un error." }
		end
	end
	
end
