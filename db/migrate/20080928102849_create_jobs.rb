class CreateJobs < ActiveRecord::Migration
  def self.up
    create_table :jobs do |t|
      t.integer :employer_id
      t.integer :employee_id
      t.decimal :price
      t.datetime :created_at
      t.datetime :accepted, :null
      t.datetime :finished, :null
      t.datetime :approved, :null

    end
  end

  def self.down
    drop_table :jobs
  end
end
