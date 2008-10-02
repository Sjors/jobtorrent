class GoogleCodeIssue < ActiveRecord::Base
  require 'rubygems'
  require 'mechanize'    

  has_many :job_google_code_issues

  def before_create
    fetch_project
    fetch_title
  end

  def before_update
    fetch_project
    fetch_title
  end
  
  def fetch_project
    self.project = nil
    self.project_url = nil
  
    self.project =  self.url.split("/")[4].capitalize
    self.project_url =  self.url.split("/")[0..4].join("/") + "/"
 end

  def fetch_title
    self.title = nil

    agent = WWW::Mechanize.new 
    self.title = agent.get(self.url).search("//span[@class='h3']").text
  end
end


