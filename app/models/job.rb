class Job < ActiveRecord::Base
  has_one :user, :foreign_key => :employer_id
  has_one :user, :foreign_key => :employee_id

  has_one :job_google_code_issue
  delegate :google_code_issue, :google_code_issue=, :to => :job_google_code_issue
end

