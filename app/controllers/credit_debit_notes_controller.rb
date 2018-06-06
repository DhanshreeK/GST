class CreditDebitNotesController < ApplicationController
   def index
    if current_user.role == 'Party'
      @credit_debit_notes = current_user.credit_debit_notes
    else
       @credit_debit_notes = CreditDebitNote.all
    end
  end

  def new
    @credit_debit_note = CreditDebitNote.new
    @item = Item.new
    @unit_of_measure = UnitOfMeasure.new
    @credit_debit_note.credit_debit_note_items.build # build ingredient attributes, nothing new here
     #@credit_debit_note.invoice_no = CreditDebitNote.set_credit_debit_note_no
    @items = Item.all
  end

  def create
    @credit_debit_note = CreditDebitNote.new(credit_debit_note_params)
    @user = current_user
    if @credit_debit_note.save
      @credit_debit_note.update!(user_id: @user.id)
      flash[:notice] = "Successfully Created credit_debit_note"
      redirect_to @credit_debit_note and return
    end
  end

  def edit
   @credit_debit_note = CreditDebitNote.find(params[:id])
 end

 def update
  @credit_debit_note = CreditDebitNote.find(params[:id])
  respond_to do |format|
    if @credit_debit_note.update(credit_debit_note_params)
      format.html { redirect_to credit_debit_note_path, notice: 'credit_debit_note was successfully updated.' }
      format.json { render :index, status: :ok, location: @credit_debit_note }
    else
      format.html { render :edit }
      format.json { render json: @credit_debit_note.errors, status: :unprocessable_entity }
    end
  end
end

def destroy
  @credit_debit_note = CreditDebitNote.find(params[:id])
  @credit_debit_note.destroy
  flash[:notice] = "Successfully destroyed credit_debit_note"
  redirect_to @credit_debit_note
end

def show
  @credit_debit_note = CreditDebitNote.find(params[:id])
   if params[:params1].present?
    @credit_debit_note.update!(total_invoice_value: params[:params1], cess: params[:params2])
  end
  respond_to do |format|
    format.html
    format.pdf do
        render pdf: "show_credit_debit_note.pdf.erb",
        orientation: 'Landscape'   
      end
    end
  end

  def show_credit_debit_note
   @credit_debit_note = CreditDebitNote.find(params[:id])
   respond_to do |format|
    format.html
    format.pdf do
        render pdf: "show_credit_debit_note.pdf.erb",
        orientation: 'Landscape'  # Excluding ".pdf" extension.
      end
    end
  end
  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def credit_debit_note_params
      params.require(:credit_debit_note).permit(:ur_types,:user_id,:note_type,:id, :date_of_original_invoice, :invoice_no, :gstin_no, :e_way_bill_no, :date_of_issue_note, :issue_note_no, :pre_gst, :place_of_supply, :customer_id, :reason_for_issuing_note, :register_type, :note_typee,credit_debit_note_items_attributes:[ :unit_price, :quantity,:item_id,:rate, :qty, :net_amt, :sgst, :cgst, :tax_rate, :tax_amt, :total_amt,:_destroy])
    end
  end
    # Never trust parameters from the scary internet, only allow the white list through.
    # def credit_debit_note_params
      # params.require(:credit_debit_note).permit(:customer_id, :credit_debit_note_no,:date, credit_debit_note_items_attributes: credit_debit_noteItem.attribute_names.map(&:to_sym).push(:_destroy))
      # credit_debit_note_items_attributes:[:number,:item_id,:_destory]
    # end
