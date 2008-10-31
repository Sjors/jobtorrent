class Payment < ActiveRecord::Base
  has_one :user, :foreign_key => :employer_id
  has_one :user, :foreign_key => :employee_id

  named_scope :verified_in, lambda {|*args| {:conditions => [ 'month(verified) = ? and year(verified) = ?',  args[0], args[1]  ] } } 

end
