# Global constants such as "SITE_URL" are set in "config/initializers/app_constants.rb"
# and read from "config/config.yml" or "config/config.local.yml" by the app_config plugin.
# You'll probably want to change them in "config/config.yml", not here.

class UserMailer < ActionMailer::Base
  def signup_notification(user)
    setup_email(user)
    @subject     = 'Please activate your new account'
  
    @body[:url]  = "#{SITE_URL}activate/#{user.activation_code}"
  
  end
  
  def activation(user)
    setup_email(user)
    @subject     = 'Your account has been activated!'
    @body[:url]  = SITE_URL
  end

  def forgot_password(user)
    setup_email(user)
    @subject     = 'You have requested to change your password'
    @body[:url]  = "#{SITE_URL}reset_password/#{user.password_reset_code}"
  end

  def reset_password(user)
    setup_email(user)
    @subject     = 'Your password has been reset.'
  end

  def message_to_admin(subject,body)
    @admin = User.find_by_login(ADMIN_LOGIN)
    @recipients  = @admin.email
    @from        = @admin.email
    @subject     = SITE_NAME
    @sent_on     = Time.now
    @subject     = subject
    @body[:body]  = body
  end

  def invoice_paid_by_other_means(invoice, means)
    @recipients  = INVOICE_ADDRESS
    @from        = SITE_EMAIL_ADDRESS
    @subject     = SITE_NAME
    @sent_on     = Time.now
    @subject     = invoice.user.login + " has paid invoice."
    @body[:url]  = "#{SITE_URL}invoices/#{invoice.id}"
    @body[:invoice] = invoice
    @body[:means] = means
    @body[:user] = invoice.user
  end

  def new_invoice(invoice)
    @recipients  = invoice.user.email
    @from        = INVOICE_ADDRESS
    @subject     = "Jobtorrent invoice " + Time.mktime(invoice.year,invoice.month).strftime("%B %Y") + "." 
    @sent_on     = Time.now
    @body[:url]  = "#{SITE_URL}invoices/#{invoice.id}"
    @body[:invoice] = invoice
    @body[:user] = invoice.user
    @body[:month] = Time.mktime(invoice.year,invoice.month).strftime("%B")
  end
  
  protected
    def setup_email(user)
      @recipients  = "#{user.email}"
      @from        = SITE_EMAIL_ADDRESS
      @subject     = SITE_NAME
      @sent_on     = Time.now
      @body[:user] = user
    end
end
