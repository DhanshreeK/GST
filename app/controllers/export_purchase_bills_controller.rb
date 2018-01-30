class ExportPurchaseBillsController < ApplicationController
  
  def index
     if current_user.role == 'Party'
       @export_export_purchase_bill_invoices = current_user.export_purchase_bills
     else
      @export_export_purchase_bill_invoices = ExportPurchaseBill.all
    end
  end

  def new
    @export_purchase_bill_invoice = ExportPurchaseBill.new
    @export_purchase_bill_invoice.export_purchase_bill_items.build # build ingredient attributes, nothing new here
    @export_purchase_bill_invoice.purchase_no = ExportPurchaseBill.set_purchase_no
 	  @items = Item.all
  end

  def create
    @export_purchase_bill_invoice = ExportPurchaseBill.new(export_purchase_params)
    @user = current_user
      if @export_purchase_bill_invoice.save
        @export_purchase_bill_invoice.update(user_id: @user.id)
         # @export_purchase_bill_invoice.update!(purchase_no: params[:export_purchase_bill][:purchase_no])
        flash[:notice] = "Successfully Created export_purchase_bill_Invoice"
        redirect_to @export_purchase_bill_invoice and return
      end
  end

  def destroy
    @export_purchase_bill_invoice = ExportPurchaseBill.find(params[:id])
    @export_purchase_bill_invoice.destroy
    flash[:notice] = "Successfully destroyed export_purchase_bill_Invoice"
    redirect_to receipes_url
  end

  def show
    @export_purchase_bill_invoice = ExportPurchaseBill.find(params[:id])
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "show_invoice.pdf.erb" ,
        orientation: 'Landscape'  # Excluding ".pdf" extension.
      end
    end
  end

def show_invoice
       @export_purchase_bill_invoice = ExportPurchaseBill.find(params[:id])
      respond_to do |format|
      format.html
      format.pdf do
        render pdf: "show_invoice.pdf.erb",
        orientation: 'Landscape'   # Excluding ".pdf" extension.
      end
    end
end
  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def export_purchase_params
      params.require(:export_purchase_bill).permit(:bill_type, :transportation_mode, :vehicle_number, :rcm, :terms_and_conditions, :narration, :customer_id, :purchase_no, :date,export_purchase_bill_items_attributes:[ :unit_price, :quantity,:item_id,:rate, :qty, :net_amt, :sgst, :cgst, :tax_rate, :net_amount, :tax_amt, :total_amt,:_destroy])
    end
end
    # Never trust parameters from the scary internet, only allow the white list through.
    # def export_purchase_bill_invoice_params
      # params.require(:export_purchase_bill_invoice).permit(:customer_id, :export_purchase_bill_invoice_no,:date, export_purchase_bill_invoice_items_attributes: export_purchase_bill_InvoiceItem.attribute_names.map(&:to_sym).push(:_destroy))
      # export_purchase_bill_invoice_items_attributes:[:number,:item_id,:_destory]
    # end

