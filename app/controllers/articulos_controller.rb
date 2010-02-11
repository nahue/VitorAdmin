class ArticulosController < ApplicationController
  
  load_and_authorize_resource
  uses_tiny_mce :options => {
  					:language => 'es',
                    :theme => 'advanced',
                    :theme_advanced_resizing => true,
                    :theme_advanced_resize_horizontal => false,
                    :plugins => %w{ table fullscreen }
                   }
  
  def show
    @articulo = Articulo.find(params[:id])
    respond_to do |format|
          format.html
          format.xml { render :xml => @articulo.to_xml }
          format.json { render :json => @articulo.to_json }
          format.rss { render :action => "feed.rxml" }
    end
  end
  def index
    @articulos = Articulo.all
    logger.debug(@articulos.to_yaml)
    respond_to do |format|
          format.html
          format.xml { render :xml => @articulos.to_xml }
          format.rss { render :action => "feed.rxml" }
    end
    
  end
  def new
  end


  def create
  	@articulo.user = current_user# if current_user?
  	
  	if @articulo.save
  		flash[:notice] = "Articulo guardado correctamente."
  		redirect_to root_url
  	else
  		flash[:notice] = "Ocurrio un error."
  		render :action => 'new'  
  	end
  end
  
  def edit
  end

  def update
    @articulo = Articulo.find(params[:id])
    if @articulo.update_attributes(params[:articulo])
      flash[:notice] = "Articulo modificado."
      redirect_to articulos_path
    else
      flash[:notice] = "No se pudo modificar el articulo."
    end
  end
  def destroy
    @articulo.destroy
    flash[:notice] = "Articulo eliminado."
    redirect_to articulos_path
    
  end
end
