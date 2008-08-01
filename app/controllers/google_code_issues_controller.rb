class GoogleCodeIssuesController < ApplicationController
  # GET /google_code_issues
  # GET /google_code_issues.xml
  def index
    @google_code_issues = GoogleCodeIssue.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @google_code_issues }
    end
  end

  # GET /google_code_issues/1
  # GET /google_code_issues/1.xml
  def show
    @google_code_issue = GoogleCodeIssue.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @google_code_issue }
    end
  end

  # GET /google_code_issues/new
  # GET /google_code_issues/new.xml
  def new
    @google_code_issue = GoogleCodeIssue.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @google_code_issue }
    end
  end

  # GET /google_code_issues/1/edit
  def edit
    @google_code_issue = GoogleCodeIssue.find(params[:id])
  end

  # POST /google_code_issues
  # POST /google_code_issues.xml
  def create
    @google_code_issue = GoogleCodeIssue.new(params[:google_code_issue])

    respond_to do |format|
      if @google_code_issue.save
        flash[:notice] = 'GoogleCodeIssue was successfully created.'
        format.html { redirect_to(@google_code_issue) }
        format.xml  { render :xml => @google_code_issue, :status => :created, :location => @google_code_issue }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @google_code_issue.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /google_code_issues/1
  # PUT /google_code_issues/1.xml
  def update
    @google_code_issue = GoogleCodeIssue.find(params[:id])

    respond_to do |format|
      if @google_code_issue.update_attributes(params[:google_code_issue])
        flash[:notice] = 'GoogleCodeIssue was successfully updated.'
        format.html { redirect_to(@google_code_issue) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @google_code_issue.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /google_code_issues/1
  # DELETE /google_code_issues/1.xml
  def destroy
    @google_code_issue = GoogleCodeIssue.find(params[:id])
    @google_code_issue.destroy

    respond_to do |format|
      format.html { redirect_to(google_code_issues_url) }
      format.xml  { head :ok }
    end
  end
end
