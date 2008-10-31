class UserAcceptsFeeStructure < ActiveRecord::Migration
  def self.up
    add_column('users', 'accepts_fee_structure', :datetime, :null => :true)
  end

  def self.down
    remove_column('users', 'accepts_fee_structure')
  end
end
