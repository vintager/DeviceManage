class AdminController < ApplicationController
  def login
    if request.post?
      user = User.authenticate(params[:userid], params[:password])
      if user
        session[:user_id] = user.id
        redirect_to(:controller=>"devices",:action => "index" )
      else
        flash.now[:notice] = "用户名/密码错误！"
      end
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "已退出系统！"
    redirect_to(:action => "login" )
  end

#  def index
#    @users = User.find(:all)
#
#    respond_to do |format|
#      format.html # index.html.erb
#      format.xml  { render :xml => @users }
#    end
#  end

end
