class EmployersController < ApplicationController
  # GET /employers
  # GET /employers.xml
  def index
    @employers = Employer.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @employers }
    end
  end

  # GET /employers/1
  # GET /employers/1.xml
  def show
    @employer = Employer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @employer }
    end
  end

  # GET /employers/new
  # GET /employers/new.xml
  def new
    @employer = Employer.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @employer }
    end
  end

  # GET /employers/1/edit
  def edit
    @employer = Employer.find(params[:id])
  end

  # POST /employers
  # POST /employers.xml
  def create
    @employer = Employer.new(params[:employer])

    respond_to do |format|
      if @employer.save
        flash[:notice] = 'Employer was successfully created.'
        format.html { redirect_to(@employer) }
        format.xml  { render :xml => @employer, :status => :created, :location => @employer }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @employer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /employers/1
  # PUT /employers/1.xml
  def update
    @employer = Employer.find(params[:id])

    respond_to do |format|
      if @employer.update_attributes(params[:employer])
        flash[:notice] = 'Employer was successfully updated.'
        format.html { redirect_to(@employer) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @employer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /employers/1
  # DELETE /employers/1.xml
  def destroy
    @employer = Employer.find(params[:id])
    @employer.destroy

    respond_to do |format|
      format.html { redirect_to(employers_url) }
      format.xml  { head :ok }
    end
  end
end
