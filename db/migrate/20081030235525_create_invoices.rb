class CreateInvoices < ActiveRecord::Migration
  def self.up
    create_table :invoices do |t|
      t.decimal :amount
      t.references :user
      t.integer :year
      t.integer :month
      t.datetime :billed_at
      t.datetime :due_at
      t.datetime :paid_at
      t.datetime :payment_confirmed_at

      t.timestamps
    end
  end

  def self.down
    drop_table :invoices
  end
end
