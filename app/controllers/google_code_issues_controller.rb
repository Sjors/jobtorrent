class GoogleCodeIssueController < ApplicationController
  layout 'application'
  
  #before_filter :find_job #, :only => []
  #before_filter :check_employer_role, :only => [:create, :destroy, :update]

  def create
    @google_code_issue = GoogleCodeIssue.new(params[:google_code_issue])
    @google_code_issue.save
  end
end

protected

  def find_job
    @job = Job.find(params[:job_id])
  end

end

