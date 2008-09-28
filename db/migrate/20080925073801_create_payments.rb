class CreatePayments < ActiveRecord::Migration
  def self.up
    create_table :payments do |t|
      t.integer :employer_id
      t.integer :employee_id
      t.integer :amount
      t.datetime :datetime
      t.boolean :verified

      t.timestamps
    end
  end

  def self.down
    drop_table :payments
  end
end
