class GoogleCodeIssue < ActiveRecord::Base
  require 'rubygems'
  require 'mechanize'    
  
  GOOGLE_CODE_URL_REGEX = /^http:\/\/code.google.com\/p\/[^\/]+\/issues\/detail\?id=[0-9]+$/i
  validates_format_of :url, :with => GOOGLE_CODE_URL_REGEX, :message => "Issue URL doesn't appear to be a valid Google Code Issue."

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
  
    begin
      self.project =  self.url.split("/")[4].capitalize
      self.project_url =  self.url.split("/")[0..4].join("/") + "/"
    rescue
      false
    end
 end

  def fetch_title
    self.title = nil

    agent = WWW::Mechanize.new 
    self.title = agent.get(self.url).search("//span[@class='h3']").text rescue false
  end
end


