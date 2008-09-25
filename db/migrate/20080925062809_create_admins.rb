class CreateAdmins < ActiveRecord::Migration
  def self.up
    create_table :admins do |t|
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :admins
  end
end
