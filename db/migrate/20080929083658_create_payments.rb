class CreatePayments < ActiveRecord::Migration
  def self.up
    create_table :payments do |t|
      t.integer :employer_id
      t.integer :employee_id
      t.integer :job_id
      t.integer :amount
      t.datetime :transferred
      t.datetime :verified
    end
  end

  def self.down
    drop_table :payments
  end
end
