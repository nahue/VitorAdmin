class Admin::UsersController < Admin::AdminController
  load_and_authorize_resource :except => :edit
  ActiveRecord::Base.include_root_in_json = false
	def new  
	    @user = User.new  
	end  
  def create  
	  @user = User.new(params[:user])  
	  if @user.save  
	    flash[:notice] = "Registration successful."  
	    redirect_to root_url  
	  else  
	    render :action => 'new'  
	  end  
	end  

	def edit
	  @user = current_user  
	end  
	  
	def destroy
	  @user.destroy
	  flash[:notice] = "Usuario eliminado."
    redirect_to users_path
	end
	
	
	
	
	def editar_usuario
	  @user = User.find(params[:user])
	end
	
	def update_usuario
		@user = User.find(params[:user])
		params[:user][:grupo_ids] ||= []  
		if @user.update_attributes(params[:user])  
		  flash[:notice] = "Successfully updated profile."  
		  redirect_to admin_url  
		else  
		  render :action => 'edit'  
		end  
	end
	
	def update  
	  @user = current_user  
	  if @user.update_attributes(params[:user])  
	    flash[:notice] = "Successfully updated profile."  
	    redirect_to admin_url  
	  else  
	    render :action => 'edit'  
	  end  
	end  
	
	def index
		@usuarios = User.all
		respond_to do |format|
			format.html
			format.json { 
				render :json => { :usuarios => @usuarios }
			}
		end
	end
end
