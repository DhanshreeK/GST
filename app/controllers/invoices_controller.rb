class InvoicesController < ApplicationController
  before_action :set_invoice, only: [:show, :edit, :update, :destroy]
  def index
    if current_user.role == 'Party'
        @invoices = current_user.invoices
        respond_to do |format|
        format.html
        format.csv { send_data @invoices.to_csv }
        format.xls { send_data @invoices.to_csv(col_sep: "\t") }
        end
    else
        @invoices = Invoice.all
    end
  end

  def new
    @invoice = Invoice.new
    @invoice.invoice_items.build # build ingredient attributes, nothing new here
    @invoice.invoice_no = Invoice.set_invoice_no
    @items = Item.all
  end

  def create
    @invoice = Invoice.new(invoice_params)
    @user = current_user
    if @invoice.save
      @invoice.update!(user_id: @user.id)
      flash[:notice] = "Successfully Created Invoice"
      redirect_to @invoice and return
    end
  end

  # def export
  #   book = Spreadsheet::Workbook.new
  #   sheet1 = book.create_worksheet :name => 'Sheet1'
  #   sheet2 = book.create_worksheet :name => 'Sheet2'
  #    sheet1.row(0).push "just text", 5.98, DateTime.now
  #     spreadsheet = StringIO.new
  #     book.write spreadsheet
  #     file = "Excelsheet"
  #     send_data spreadsheet.string, :filename => "#{file}", :type =>  "application/vnd.ms-excel"
  # end

  def edit
  end

  def update
    respond_to do |format|
      if @invoice.update(invoice_params)
        format.html { redirect_to invoice_path, notice: 'invoice was successfully updated.' }
        format.json { render :index, status: :ok, location: @invoice }
      else
        format.html { render :edit }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @invoice.destroy
    flash[:notice] = "Successfully destroyed Invoice"
    redirect_to @invoice
  end

  def show
    if params[:params1].present?
      @invoice.update!(total_invoice_value: params[:params1], cess: params[:params2])
     
    end
    respond_to do |format|
      format.html
      format.pdf do
          render pdf: "show_invoice.pdf.erb"   # Excluding ".pdf" extension.
        end
      end
  end


  def show_invoice
   @invoice = Invoice.find(params[:id])
   respond_to do |format|
    format.html
    format.pdf do
        render pdf: "show_invoice.pdf.erb"   # Excluding ".pdf" extension.
      end
    end
  end
  
  private

    def set_invoice
      @invoice = Invoice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def invoice_params
      params.require(:invoice).permit(:pos,:tax_rate,:ebay_bill_no,:rcm,:user_id,:id,:gstr_holder,:customer_id, :invoice_no,:date,invoice_items_attributes:[ :unit_price, :quantity,:item_id,:rate, :qty, :net_amt, :sgst, :cgst, :tax_rate, :tax_amt, :total_amt,:_destroy])
    end
end
    # Never trust parameters from the scary internet, only allow the white list through.
    # def invoice_params
      # params.require(:invoice).permit(:customer_id, :invoice_no,:date, invoice_items_attributes: InvoiceItem.attribute_names.map(&:to_sym).push(:_destroy))
      # invoice_items_attributes:[:number,:item_id,:_destory]
    # end