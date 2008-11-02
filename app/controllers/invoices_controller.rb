class InvoicesController < ApplicationController
  before_filter :check_administrator_role, :only => [:edit, :update, :destroy, :new, :create]
  
  # GET /invoices
  # GET /invoices.xml
  def index
    if current_user.has_role?('administrator')
      @invoices = Invoice.find(:all)
    else 
      @invoices = current_user.invoices
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @invoices }
    end
  end

  # GET /invoices/1
  # GET /invoices/1.xml
  def show
    @invoice = Invoice.find(params[:id])
    if @invoice.user == current_user
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @invoice }
      end
    else
      redirect_back_or_default(root_path)
    end
  end

  # GET /invoices/new
  # GET /invoices/new.xml
  def new
    @invoice = Invoice.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @invoice }
    end
  end

  # GET /invoices/1/edit
  def edit
    @invoice = Invoice.find(params[:id])
  end

  # POST /invoices
  # POST /invoices.xml
  def create
    @invoice = Invoice.new(params[:invoice])

    respond_to do |format|
      if @invoice.save
        flash[:notice] = 'Invoice was successfully created.'
        format.html { redirect_to(@invoice) }
        format.xml  { render :xml => @invoice, :status => :created, :location => @invoice }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @invoice.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /invoices/1
  # PUT /invoices/1.xml
  def update
    @invoice = Invoice.find(params[:id])

    respond_to do |format|
      if @invoice.update_attributes(params[:invoice])
        flash[:notice] = 'Invoice was successfully updated.'
        format.html { redirect_to(@invoice) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @invoice.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /invoices/1
  # DELETE /invoices/1.xml
  def destroy
    @invoice = Invoice.find(params[:id])
    @invoice.destroy

    respond_to do |format|
      format.html { redirect_to(invoices_url) }
      format.xml  { head :ok }
    end
  end

  def paid
    invoice = Invoice.find(params[:id])    
    if current_user == invoice.user and invoice.paid_at.nil?
      invoice.paid_at = 0.hours.from_now
      invoice.save

      means = params[:means]
      
      if means == "paypal" then
        # Nothing to do; Paypal sends an email when this happens.
      else
        # Send an email to invoices mail address about the invoice        
        UserMailer.deliver_invoice_paid_by_other_means(invoice, means)  
      end

      flash[:notice] = "Thanks for paying your invoice! Jobtorrent will confirm it as soon as possible. "
      redirect_to :action => 'index'
    else
      redirect_to :action => 'index'
    end

  end
end
