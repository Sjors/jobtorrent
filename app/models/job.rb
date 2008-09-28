class Job < ActiveRecord::Base
  has_one :user, :foreign_key => :employer_id
  has_one :user, :foreign_key => :employee_id
end

