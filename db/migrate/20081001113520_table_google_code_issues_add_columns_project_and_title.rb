class TableGoogleCodeIssuesAddColumnsProjectAndTitle < ActiveRecord::Migration
  def self.up
    add_column "google_code_issues", "project", :string 
    add_column "google_code_issues", "project_url", :string 
    add_column "google_code_issues", "title", :string
    
    # Process existing url's:
    for issue in GoogleCodeIssue.find(:all) do
      issue.fetch_project
      issue.fetch_title
      issue.save
    end

  end

  def self.down
    remove_column "google_code_issues", "project" 
    remove_column "google_code_issues", "project_url" 
    remove_column "google_code_issues", "title" 
  end
end
