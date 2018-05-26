class ExportInvoicesController < ApplicationController

  def index
    if current_user.role == 'Party'
      @export_invoices = current_user.export_invoices
    else
      @export_invoices = ExportInvoice.all
    end
  end

  def new
    @export_invoice = ExportInvoice.new
    @item = Item.new
    @customer = Customer.new
    @unit_of_measure = UnitOfMeasure.new
    @export_invoice.export_invoice_items.build # build ingredient attributes, nothing new here
    @export_invoice.export_invoice_number = ExportInvoice.set_invoice_no
    @items = Item.all
  end

  def create
    @export_invoice = ExportInvoice.new(export_invoice_params)
    @user = current_user
    if @export_invoice.save
      @export_invoice.update!(user_id: @user.id)
      flash[:notice] = "Successfully Created Invoice"
      redirect_to @export_invoice and return
    end
  end

  def edit
   @export_invoice = ExportInvoice.find(params[:id])
 end

 def update
  @export_invoice = ExportInvoice.find(params[:id])
  respond_to do |format|
    if @export_invoice.update(export_invoice_params)
      @export_invoice.assign_attributes(id: params[:id])
      @export_invoice.assign_attributes(id: params[:id])
      format.html { redirect_to invoice_path, notice: 'invoice was successfully updated.' }
      format.json { render :index, status: :ok, location: @export_invoice }
    else
      format.html { render :edit }
      format.json { render json: @export_invoice.errors, status: :unprocessable_entity }
    end
  end
end

def destroy
  @export_invoice = ExportInvoice.find(params[:id])
  @export_invoice.destroy
  flash[:notice] = "Successfully destroyed Invoice"
  redirect_to @export_invoice
end

def show
  @export_invoice = ExportInvoice.find(params[:id])
  respond_to do |format|
    format.html
    format.pdf do
        render pdf: "show_export_invoice.pdf.erb", 
        orientation: 'Landscape'  # Excluding ".pdf" extension.
      end
    end
  end

  def show_export_invoice
   @export_invoice = ExportInvoice.find(params[:id])
   respond_to do |format|
    format.html
    format.pdf do
        render pdf: "show_export_invoice.pdf.erb" ,
        orientation: 'Landscape'  # Excluding ".pdf" extension.
      end
    end
  end
  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def export_invoice_params
      params.require(:export_invoice).permit(:terms_and_conditions,:narration,:vehicle_number,:transportation_mode,:export_type,:pos,:port_code,:shipping_bill_no,:customer_id, :export_invoice_number,:export_invoice_date,export_invoice_items_attributes:[:id, :unit_price, :quantity,:item_id,:rate, :qty, :net_amt, :sgst, :cgst, :tax_rate, :tax_amt, :total_amt,:_destroy])
    end
  end