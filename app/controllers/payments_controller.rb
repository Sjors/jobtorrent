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

  def show
    if params[:id] 
      @payment = Payment.find(params[:id])
    else
      @payment = Payment.find(:first, :conditions => {:job_id => params[:job_id] })
    end      

    if current_user.has_role?("employer")
      @role = "employer"
    else
      @role = "employee"
    end

    if (@role == "employer" and @payment.employer_id == current_user.id) or
        (@role == "employee" and @payment.employee_id == current_user.id)

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @payment }
      end  
    else
      redirect_to :action => 'index'
    end
  end

  def payed
    payment = Payment.find(params[:id])    
    if current_user.has_role?("employer") and current_user.id == payment.employer_id and payment.transferred.nil?
      payment.transferred = Time.now
      payment.save

      flash[:notice] = "Payment complete. " + User.find(payment.employee_id).login + " will check if it worked out."
      redirect_to :action => 'index'
    else
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
