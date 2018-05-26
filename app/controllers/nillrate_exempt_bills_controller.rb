class NillrateExemptBillsController < ApplicationController
  def index
    if current_user.role == 'Party'
        @nillrate_exempt_bill_invoices = current_user.nillrate_exempt_bills
      else 
        @nillrate_exempt_bill_invoices = NillrateExemptBill.all
    end
  end

  def new
    @nillrate_exempt_bill_invoice = NillrateExemptBill.new
    @item = Item.new
    @unit_of_measure = UnitOfMeasure.new
    @nillrate_exempt_bill_invoice.nillrate_exempt_bill_items.build # build ingredient attributes, nothing new here
    @nillrate_exempt_bill_invoice.purchase_no = NillrateExemptBill.set_purchase_no
    @items = Item.all
  end

  def create
    @nillrate_exempt_bill_invoice = NillrateExemptBill.new(nillrate_exempt_bill_invoice_params)
    @user = current_user
      if @nillrate_exempt_bill_invoice.save
        @nillrate_exempt_bill_invoice.update(user_id: @user.id)
        flash[:notice] = "Successfully Created nillrate_exempt_bill_Invoice"
        redirect_to @nillrate_exempt_bill_invoice and return
      end
  end

  def destroy
    @nillrate_exempt_bill_invoice = NillrateExemptBill.find(params[:id])
    @nillrate_exempt_bill_invoice.destroy
    flash[:notice] = "Successfully destroyed nillrate_exempt_bill_Invoice"
    redirect_to receipes_url
  end

  def show
    @nillrate_exempt_bill_invoice = NillrateExemptBill.find(params[:id])
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "show_invoice.pdf.erb" ,
        orientation: 'Landscape'   # Excluding ".pdf" extension.
      end
    end
  end

  def edit
    @nillrate_exempt_bill_invoice = NillrateExemptBill.find(params[:id])
  end

  def update
    @nillrate_exempt_bill_invoice = NillrateExemptBill.find(params[:id])
    respond_to do |format|
      if @nillrate_exempt_bill_invoice.update(nillrate_exempt_bill_invoice_params)
        @nillrate_exempt_bill_invoice.assign_attributes(id: params[:id])
        format.html { redirect_to nillrate_exempt_bill_path, notice: 'nillrate_exempt_bill_invoice was successfully updated.' }
        format.json { render :index, status: :ok, location: @nillrate_exempt_bill_invoice }
      else
        format.html { render :edit }
        format.json { render json: @nillrate_exempt_bill_invoice.errors, status: :unprocessable_entity }
      end
    end
  end

def show_invoice
       @nillrate_exempt_bill_invoice = NillrateExemptBill.find(params[:id])
      respond_to do |format|
      format.html
      format.pdf do
        render pdf: "show_invoice.pdf.erb" ,
        orientation: 'Landscape'  # Excluding ".pdf" extension.
      end
    end
end
  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def nillrate_exempt_bill_invoice_params
      params.require(:nillrate_exempt_bill).permit(:customer_id, :purchase_no, :date,nillrate_exempt_bill_items_attributes:[:id,:unit_price, :item_id, :quantity, :rate, :qty, :net_amt, :sgst, :cgst, :tax_rate, :net_amount, :tax_amt, :total_amt,:_destroy])
    end
end
    # Never trust parameters from the scary internet, only allow the white list through.
    # def nillrate_exempt_bill_invoice_params
      # params.require(:nillrate_exempt_bill_invoice).permit(:customer_id, :nillrate_exempt_bill_invoice_no,:date, nillrate_exempt_bill_invoice_items_attributes: nillrate_exempt_bill_InvoiceItem.attribute_names.map(&:to_sym).push(:_destroy))
      # nillrate_exempt_bill_invoice_items_attributes:[:number,:item_id,:_destory]
    # end

