class Invoice < ActiveRecord::Base
  belongs_to :user  

  def self.total_for(month, year)
    total =  0
    for invoice in Invoice.find(:all, :conditions => {:year => year, :month => month})
      total = total + invoice.amount
    end
    return total
  end 

  named_scope :billed_in, lambda {|*args| {:conditions => {:month => args[0], :year => args[1] } } } 
end
