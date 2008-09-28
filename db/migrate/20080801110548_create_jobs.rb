class CreateJobs < ActiveRecord::Migration
  def self.up
    create_table :jobs do |t|
      t.integer :employer_id
      t.integer :employee_id
      t.integer :price_in_cents
      t.datetime :created
      t.datetime :accepted
      t.datetime :finished
      t.datetime :approved

      t.timestamps
    end
  end

  def self.down
    drop_table :jobs
  end
end
