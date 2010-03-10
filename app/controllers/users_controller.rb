class UsersController < ApplicationController
  # GET /users
  # GET /users.xml
  def index
    @users = User.paginate(:per_page => 20, :page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        flash[:notice] = 'User was successfully created.'
        format.html { redirect_to(@user) }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'User was successfully updated.'
        format.html { redirect_to(@user) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    if session[:user_id]==@user.id
      flash[:notice] = 'Can not remove current user!'
    else
      @user.destroy
    end
    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
  
  def get_query
    @user = User.new
  end

  def query
    conds = Hash.new
    params[:user].each do |key, value|
      conds.store(key, value) unless value.blank?
    end
    conds["department"]=departments.names if conds["department"].blank?
    
    @users = User.paginate(:all, :conditions=>conds,:per_page => 20, :page => params[:page])

    render :action => "index"
  end

  def init_password
    @user = User.new
  end

  def update_password
    @user=User.find_by_userid(params[:user][:userid])
    #render :action => "init_password" if @user
    if @user then
      respond_to do |format|
        if @user.update_attributes(params[:user])
          flash[:notice] = "User was successfully updated."
          format.html { redirect_to(@user) }
          format.xml  { head :ok }
        else
          format.html { render :action => "init_password" }
          format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
        end
      end
    else
      flash[:notice] = "用户id为#{params[:user][:userid]}的用户不存在！"
      redirect_to :action => "init_password"
    end
  end
end
