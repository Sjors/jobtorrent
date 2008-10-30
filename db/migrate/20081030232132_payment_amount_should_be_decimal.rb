class PaymentAmountShouldBeDecimal < ActiveRecord::Migration
  def self.up
    change_column('payments', 'amount', 'decimal' )  
  end

  def self.down
  end
end
