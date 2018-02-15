class B2bCompositesController < ApplicationController

	before_action :set_invoice, only: [:show, :edit, :update, :destroy]
  def index
    if current_user.role == 'Party'
        @b2b_composites = current_user.b2b_composites
        respond_to do |format|
        format.html
        format.csv { send_data @b2b_composites.to_csv }
        format.xls { send_data @b2b_composites.to_csv(col_sep: "\t") }
        end
    else
        @b2b_composites = B2bComposite.all
    end
  end


  	def new
		@b2b_composite = B2bComposite.new
		@b2b_composite.b2b_composite_items.build # build ingredient attributes, nothing new here
	    # @b2b_composite.invoice_no = B2bComposite.set_invoice_no
	    @items = Item.all
	end

  def create
    @b2b_composite = B2bComposite.new(invoice_params)
    @user = current_user
    if @b2b_composite.save
      @b2b_composite.update!(user_id: @user.id)
      flash[:notice] = "Successfully Created Invoice"
      redirect_to @b2b_composite and return
    end
  end

  def load_item_data
    @item = B2bComposite.shod(params[:id])
    @item.b2b_composite_items
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
      if @b2b_composite.update(invoice_params)
        @b2b_composite.assign_attributes(id: params[:id])
        format.html { redirect_to invoice_path, notice: 'invoice was successfully updated.' }
        format.json { render :index, status: :ok, location: @b2b_composite }
      else
        format.html { render :edit }
        format.json { render json: @b2b_composite.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @b2b_composite.destroy
    flash[:notice] = "Successfully destroyed Invoice"
    redirect_to @b2b_composite
  end

  def show
    if params[:params1].present?
      @b2b_composite.update!(total_b2b_composite_value: params[:params1], cess: params[:params2])
    end
    respond_to do |format|
      format.html
      format.pdf do
          render pdf: "print_pdf.pdf.erb"   # Excluding ".pdf" extension.
        end
      end
  end


  def print_pdf
   @b2b_composite = B2bComposite.find(params[:id])
   respond_to do |format|
    format.html
    format.pdf do
        render pdf: "print_pdf.pdf.erb"
      end
    end
  end
  
  private

    def set_invoice
      @b2b_composite = B2bComposite.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def invoice_params
      params.require(:b2b_composite).permit(:supply_type ,:total_b2b_composite_value,:invoice_type,:tax_rate,:rcm,:user_id,:customer_id, :invoice_number,:invoice_date,b2b_composite_items_attributes:[:id ,:unit_price, :quantity,:item_id,:rate, :qty, :net_amt, :sgst, :cgst, :tax_rate, :tax_amt, :total_amt,:_destroy])
    end
end
