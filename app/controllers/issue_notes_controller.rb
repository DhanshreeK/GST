class IssueNotesController < ApplicationController
  def index
     current_user.role == 'Party' ? @issue_notes = current_user.issue_notes :  @issue_notes = IssueNote.all
  end

  def new
    @issue_note = IssueNote.new
     @item = Item.new
    @unit_of_measure = UnitOfMeasure.new
    @issue_note.issue_note_items.build # build ingredient attributes, nothing new here
    #@issue_note.invoice_no = IssueNote.set_issue_note_no
    @items = Item.all
  end

  def create
    @issue_note = IssueNote.new(issue_note_params)
      @user = current_user
    if @issue_note.save
      @issue_note.update!(user_id: @user.id)
      flash[:notice] = "Successfully Created issue_note"
      redirect_to @issue_note and return
    end
  end

  def edit
   @issue_note = IssueNote.find(params[:id])
  end

 def update
  @issue_note = IssueNote.find(params[:id])
  respond_to do |format|
    if @issue_note.update(issue_note_params)
      format.html { redirect_to issue_note_path, notice: 'issue_note was successfully updated.' }
      format.json { render :index, status: :ok, location: @issue_note }
    else
      format.html { render :edit }
      format.json { render json: @issue_note.errors, status: :unprocessable_entity }
    end
  end
end

def destroy
  @issue_note = IssueNote.find(params[:id])
  @issue_note.destroy
  flash[:notice] = "Successfully destroyed issue_note"
  redirect_to @issue_note
end

def show
  @issue_note = IssueNote.find(params[:id])
   if params[:params1].present?
    @issue_note.update!(total_invoice_value: params[:params1], cess: params[:params2])
  end
  respond_to do |format|
    format.html
    format.pdf do
        render pdf: "show_issue_note.pdf.erb" ,
        orientation: 'Landscape' # Excluding ".pdf" extension.
      end
    end
  end

  def show_issue_note
   @issue_note = IssueNote.find(params[:id])
   respond_to do |format|
    format.html
    format.pdf do
        render pdf: "show_issue_note.pdf.erb" ,
        orientation: 'Landscape'  # Excluding ".pdf" extension.
      end
    end
  end
  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def issue_note_params
      params.require(:issue_note).permit(:ur_types,:document_type,:note_type,:id, :date_of_original_invoice, :invoice_no, :gstin_no, :e_way_bill_no, :date_of_issue_note, :issue_note_no, :pre_gst, :place_of_supply, :customer_id, :reason_for_issuing_note, :register_type, :note_typee,issue_note_items_attributes:[ :unit_price, :quantity,:item_id,:rate, :qty, :net_amt, :sgst, :cgst, :tax_rate, :tax_amt, :total_amt,:_destroy])
    end
end
