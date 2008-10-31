class Invoice < ActiveRecord::Base
  def self.total_for(month, year)
    total =  0
    for invoice in Invoice.find(:all, :conditions => {:year => year, :month => month})
      total = total + invoice.amount
    end
    return total
  end 
end
