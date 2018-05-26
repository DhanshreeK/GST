class PurchaseBillsController < ApplicationController
  def index
     if current_user.role == 'Party'
      @purchase_bill_invoices= current_user.purchase_bills
    else
      @purchase_bill_invoices = PurchaseBill.all
  end
  end

  def new
    @purchase_bill_invoice = PurchaseBill.new
    @item = Item.new
    @unit_of_measure = UnitOfMeasure.new
    @purchase_bill_invoice.purchase_bill_items.build # build ingredient attributes, nothing new here
   # @purchase_bill_invoice.purchase_no = PurchaseBill.set_purchase_no
    @items = Item.all
    @general_setting = GeneralSetting.first
  end


  def edit
    @purchase_bill_invoice = PurchaseBill.find(params[:id]) 
  end


  def update
    @purchase_bill_invoice = PurchaseBill.find(params[:id])
    respond_to do |format|
      if @purchase_bill_invoice.update(purchase_bill_invoice_params)
       @purchase_bill_invoice.assign_attributes(id: params[:id])
        format.html { redirect_to @purchase_bill_invoice, notice: 'Party was successfully updated.' }
        format.json { render :show, status: :ok, location: @purchase_bill_invoice }
      else
        format.html { render :edit }
        format.json { render json: @purchase_bill_invoice.errors, status: :unprocessable_entity }
      end
    end
  end


  def create
    @purchase_bill_invoice = PurchaseBill.new(purchase_bill_invoice_params)
    @user = current_user
    if @purchase_bill_invoice.save
       @purchase_bill_invoice.update!(user_id: @user.id)
        flash[:notice] = "Successfully Created purchase_bill_Invoice"
        redirect_to @purchase_bill_invoice and return
      end
  end



  def destroy
    @purchase_bill_invoice = PurchaseBill.find(params[:id])
    @purchase_bill_invoice.destroy
    flash[:notice] = "Successfully destroyed purchase_bill_Invoice"
    redirect_to purchase_bills_path
  end

  def show
    @purchase_bill_invoice = PurchaseBill.find(params[:id])
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "show_invoice.pdf.erb",
        orientation: 'Landscape'   # Excluding ".pdf" extension.
      end
    end
  end

def show_invoice
       @purchase_bill_invoice = PurchaseBill.find(params[:id])
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
    def purchase_bill_invoice_params
      params.require(:purchase_bill).permit( :transportation_mode, :vehicle_number,:rcm,:narration,:terms_and_conditions,:bill_type,:pos,:customer_id, :purchase_no, :purchase_bill_invoice_no,:date,purchase_bill_items_attributes:[:id, :unit_price, :quantity,:item_id,:rate, :qty, :net_amt, :item_description, :sgst, :cgst, :tax_rate, :net_amount, :tax_amt, :total_amt,:_destroy])
    end
end
    # Never trust parameters from the scary internet, only allow the white list through.
    # def purchase_bill_invoice_params
      # params.require(:purchase_bill_invoice).permit(:customer_id, :purchase_bill_invoice_no,:date, purchase_bill_invoice_items_attributes: purchase_bill_InvoiceItem.attribute_names.map(&:to_sym).push(:_destroy))
      # purchase_bill_invoice_items_attributes:[:number,:item_id,:_destory]
    # end

