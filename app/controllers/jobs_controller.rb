class JobsController < ApplicationController
  # GET /jobs
  # GET /jobs.xml
  def index
    if current_user.has_role?("employee")
      employee_index
    else
      if current_user.has_role?("employer")
        employer_index
      else
        redirect_to :root
      end
    end 
  end

  def employer_index
    if current_user.has_role?("employer")
      @role = "employer"
      @jobs = Job.find(:all, :conditions => {:employer_id => current_user.id})

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @jobs }
      end
    else
      redirect_to :root
    end
  end

  def employee_index
    if current_user.has_role?("employee")
      @jobs = Job.find(:all)
      @role = "employee"
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @jobs }
      end
    else
      redirect_to :root
    end
  end
  # GET /jobs/1
  # GET /jobs/1.xml
  def show
    @job = Job.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @job }
    end
  end

  # GET /jobs/new
  # GET /jobs/new.xml
  def new
    @job = Job.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @job }
    end
  end

  # GET /jobs/1/edit
  def edit
    @job = Job.find(params[:id])
  end

  # POST /jobs
  # POST /jobs.xml
  def create
    @job = Job.new(params[:job])
  
    @job.employer_id = current_user.id
    @job.price = @job.price
    
    respond_to do |format|
      if @job.save
        store_url(@job, params[:google_code_issue])
        flash[:notice] = 'Job was successfully created.'
        format.html { redirect_to(@job) }
        format.xml  { render :xml => @job, :status => :created, :location => @job }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @job.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /jobs/1
  # PUT /jobs/1.xml
  def update
    @job = Job.find(params[:id])
    if current_user.has_role?("employer") and @job.finished.nil? and current_user.id == @job.employer_id

      update_url(@job, params[:google_code_issue])

      respond_to do |format|
        if @job.update_attributes(params[:job])
          flash[:notice] = 'Job was successfully updated.'
          format.html { redirect_to(@job) }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @job.errors, :status => :unprocessable_entity }
        end
      end
    else
      redirect_to :action => 'index'
    end
  end

  ## DELETE /jobs/1
  ## DELETE /jobs/1.xml
  #def destroy
  #  @job = Job.find(params[:id])
  #  @job.destroy

  #  respond_to do |format|
  #    format.html { redirect_to(jobs_url) }
  #    format.xml  { head :ok }
  #  end
  #end
 
  def accept
    if current_user.has_role?("employee") 
      job = Job.find(params[:id])
      if job.accepted.nil?
        job.accepted = Time.now
        job.employee_id = current_user.id
        job.save
      end
    end
    redirect_to :action => "index" 
  end

  def finish
    if current_user.has_role?("employee")
      job = Job.find(params[:id])
      if job.finished.nil? and job.employee_id == current_user.id
        job.finished = Time.now
        job.save
      end
    end
    redirect_to :action => "index" 
  end

  def approve
    if current_user.has_role?("employer")
      job = Job.find(params[:id])
      if job.employer_id == current_user.id and job.approved.nil? and not(job.finished.nil?) 
        job.approved = Time.now
        job.save
        pay = Payment.new
        pay.employer_id = job.employer_id
        pay.employee_id = job.employee_id
        pay.job_id = job.id
        pay.amount = job.price
        pay.save
      end
    end
    redirect_to :action => "index" 
  end

  private
  def store_url(job, google_code_issue_params)
    gc_issue = GoogleCodeIssue.new(google_code_issue_params)
    gc_issue.save
    job_gc = JobGoogleCodeIssue.new
    job_gc.job_id = job.id
    job_gc.google_code_issue_id = gc_issue.id
    job_gc.save 
  end

  def update_url(job, google_code_issue_params)
    job.google_code_issue.url = google_code_issue_params[:url]
    job.google_code_issue.update
  end
end
