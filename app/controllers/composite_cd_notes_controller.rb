class CompositeCdNotesController < ApplicationController
	before_action :set_invoice, only: [:show, :edit, :update, :destroy]
  def index
    if current_user.role == 'Party'
        @composite_cd_notes = current_user.composite_cd_notes
        respond_to do |format|
        format.html
        format.csv { send_data @composite_cd_note.to_csv }
        format.xls { send_data @composite_cd_note.to_csv(col_sep: "\t") }
        end
    else
        @composite_cd_notes = CompositeCdNote.all
    end
  end


  	def new
		@composite_cd_note = CompositeCdNote.new
		@composite_cd_note.composite_cd_note_items.build # build ingredient attributes, nothing new here
	    # @composite_cd_note.invoice_no = CompositeCdNote.set_invoice_no
	    @items = Item.all
	end

  def create
    @composite_cd_note = CompositeCdNote.new(invoice_params)
    @user = current_user
    if @composite_cd_note.save
      @composite_cd_note.update!(user_id: @user.id)
      flash[:notice] = "Successfully Created Invoice"
      redirect_to @composite_cd_note and return
    end
  end

  def load_item_data
    @item = CompositeCdNote.shod(params[:id])
    @item.composite_cd_note_items
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
      if @composite_cd_note.update(invoice_params)
        @composite_cd_note.assign_attributes(id: params[:id])
        format.html { redirect_to invoice_path, notice: 'invoice was successfully updated.' }
        format.json { render :index, status: :ok, location: @composite_cd_note }
      else
        format.html { render :edit }
        format.json { render json: @composite_cd_note.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @composite_cd_note.destroy
    flash[:notice] = "Successfully destroyed Invoice"
    redirect_to @composite_cd_note
  end

  def show
    if params[:params1].present?
      @composite_cd_note.update!(total_invoice_value: params[:params1], cess: params[:params2])
    end
    respond_to do |format|
      format.html
      format.pdf do
          render pdf: "print_pdf.pdf.erb"   # Excluding ".pdf" extension.
        end
      end
  end


  def print_pdf
   @composite_cd_note = CompositeCdNote.find(params[:id])
   respond_to do |format|
    format.html
    format.pdf do
        render pdf: "print_pdf.pdf.erb"
      end
    end
  end
  
  private

    def set_invoice
      @composite_cd_note = CompositeCdNote.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def invoice_params
      params.require(:composite_cd_note).permit(:service_code, :register_type ,:note_type,:total_invoice_value,
        :invoice_type,:tax_rate,
        :rcm,:user_id,:customer_id,
         :invoice_number,:invoice_date,
          :refund_voucher_number,
           :refund_voucher_date,
            :payment_voucher_number,
             :pregst, :document_type, 
             :supply_type, :reverse_charge,
              :refund_voucher_value, :reason_for_issuing_document,
              composite_cd_note_items_attributes:[:id ,:unit_price,
               :quantity,:item_id,:rate, :qty, 
               :net_amt, :sgst, :cgst, :tax_rate,
                :tax_amt, :total_amt,:_destroy])
    end
end
