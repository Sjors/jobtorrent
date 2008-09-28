class CreateGoogleCodeIssues < ActiveRecord::Migration
  def self.up
    create_table :google_code_issues do |t|
      t.string :url
      t.string :status

      t.timestamps
    end
  end

  def self.down
    drop_table :google_code_issues
  end
end
