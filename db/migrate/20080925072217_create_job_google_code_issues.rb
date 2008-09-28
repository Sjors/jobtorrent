class CreateJobGoogleCodeIssues < ActiveRecord::Migration
  def self.up
    create_table :job_google_code_issues do |t|
      t.references :job
      t.references :google_code_issue

      t.timestamps
    end
  end

  def self.down
    drop_table :job_google_code_issues
  end
end
