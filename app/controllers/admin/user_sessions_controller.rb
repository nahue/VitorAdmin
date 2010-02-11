class Admin::UserSessionsController < Admin::AdminController
  def new
  	@user_session = UserSession.new  
  end

  def create  
    @user_session = UserSession.new(params[:user_session])  
    if @user_session.save  
      flash[:success] = "Usuario encontrado, se inicio sesion."  
      redirect_to admin_url  
    else  
      render :action => 'new'  
    end  
  end  
  
  def destroy  
    @user_session = UserSession.find  
    @user_session.destroy  
    flash[:notice] = "Ha cerrado la sesion."  
    redirect_to admin_url  
  end  
end
