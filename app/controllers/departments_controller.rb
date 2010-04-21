class DepartmentsController < ApplicationController
  # GET /departments
  # GET /departments.xml
  def index
    @departments = array_paginate(departments,20)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @departments }
    end
  end

  # GET /departments/1
  # GET /departments/1.xml
  def show
    @department = Department.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @department }
    end
  end

  # GET /departments/new
  # GET /departments/new.xml
  def new
    @department = Department.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @department }
    end
  end

  # GET /departments/1/edit
  def edit
    @department = Department.find(params[:id])
  end

  # POST /departments
  # POST /departments.xml
  def create
    #将department的parent字段设置为下拉列表中上级单位的id值
    params[:department][:parent]=Department.find_by_name(params[:department][:parent])
    @department = Department.new(params[:department])

    respond_to do |format|
      if @department.save
        flash[:notice] = '部门添加成功！'
        format.html { redirect_to(@department) }
        format.xml  { render :xml => @department, :status => :created, :location => @department }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @department.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /departments/1
  # PUT /departments/1.xml
  def update
    @department = Department.find(params[:id])
    params[:department][:parent]=Department.find_by_name(params[:department][:parent])
    #    @parent_departments=get_names(get_parent_department_tree_for_currentuser)
    
    respond_to do |format|
      if @department.update_attributes(params[:department])
        flash[:notice] = '部门信息修改成功！'
        format.html { redirect_to(@department) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @department.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /departments/1
  # DELETE /departments/1.xml
  def destroy
    @department = Department.find(params[:id])
    @department.destroy

    respond_to do |format|
      format.html { redirect_to(departments_url) }
      format.xml  { head :ok }
    end
  end


  def get_query
    @department = Department.new
  end

  def query
    conds = Hash.new
    params[:department].each do |key, value|
      conds.store(key, value) unless value.blank?
    end

    @departments = array_paginate(Department.find(:all, :conditions=>find_like(conds).to_s)&departments,20)
#    @departments = Department.paginate(:all, :conditions=>find_like(conds).to_s,:per_page => 20, :page => params[:page])
    
    render :action => "index"
  end
  
end
