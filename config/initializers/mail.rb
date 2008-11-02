# Email settings for your own server
if MAIL_METHOD == "sendmail"
	ActionMailer::Base.delivery_method = :sendmail

end

if MAIL_METHOD == "gmail"
	# Email settings for Google gmail
	require 'smtp_tls'
	ActionMailer::Base.delivery_method = :smtp
	ActionMailer::Base.smtp_settings = {
	  :address => "smtp.gmail.com",
	  :port => 587,
	  :domain => "localhost",
	  :authentication => :plain,
	  :user_name => GOOGLE_ACCOUNT_LOGIN,
	  :password => GOOGLE_ACCOUNT_PASSWORD
	}
end
