class JobGoogleCodeIssue < ActiveRecord::Base
  belongs_to :google_code_issue
  belongs_to :job
end

