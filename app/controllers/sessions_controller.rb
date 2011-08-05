class SessionsController < ApplicationController
#new was added by myself
  def new
    # @user = User.new
# 
    # respond_to do |format|
      # format.html # new.html.erb
      # format.xml  { render :xml => @user }
    # end
  end

  def create
    if user = User.authenticate(params[:name],params[:password])
      session[:user_id] = user.id
      redirect_to store_url
     else
       redirect_to login_url, :alert=>"Invalid user/password conbination"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to store_url, :notice => "Logged out"
  end

end
