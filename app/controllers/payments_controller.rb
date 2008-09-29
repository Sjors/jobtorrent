class PaymentsController < ApplicationController
  # GET /payments
  # GET /payments.xml
  def index
    if current_user.has_role?("employer")
      @role = "employer"
      @payments = Payment.find(:all, :conditions => {:employer_id => current_user.id} )
    else
      @role = "employee"
      @payments = Payment.find(:all, :conditions => {:employee_id => current_user.id} )
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @payments }
    end
  end

  def pay
    #redirect_to "http://www.paypal.com/"
    if params[:id].nil? 
      payment = Payment.find(:first, :conditions => {:job_id => params[:job_id]})
    else
      payment = Payment.find(params[:id])
    end

    if current_user.has_role?("employer") and current_user.id == payment.employer_id
      redirect_to :action => 'payed', :id => payment.id 
    end
  end
  
  def payed
    payment = Payment.find(params[:id])    
    if current_user.has_role?("employer") and current_user.id == payment.employer_id
      payment.transferred = Time.now
      payment.save

      flash[:notice] = "Payment complete. " + User.find(payment.employee_id).login + " will check if it worked out."
      redirect_to :action => 'index'
    end

  end

  def confirm
    payment = Payment.find(params[:id])    
    if current_user.has_role?("employee") and current_user.id == payment.employee_id and !payment.transferred.nil? and payment.verified.nil?
      payment.verified = Time.now
      payment.save

      flash[:notice] = "Thanks for confirming the payment."      
      redirect_to :action => 'index'
    end

  end

end
