class OtherChallansController < ApplicationController
  def index
    if current_user.role == 'Party'
      @other_challans = current_user.other_challans
    else
      @other_challans = OtherChallan.all
    end
  end

  def new
    @other_challan = OtherChallan.new
    @item = Item.new
    @unit_of_measure = UnitOfMeasure.new
    @other_challan.other_challan_items.build # build ingredient attributes, nothing new here
    @items = Item.all
  end

  def create
    @other_challan = OtherChallan.new(other_challan_params)
    @user = current_user
    if @other_challan.save
      @other_challan.update!(user_id: @user.id)
      flash[:notice] = "Successfully Created Invoice"
      redirect_to @other_challan and return
    end
  end

  def edit
   @other_challan = OtherChallan.find(params[:id])
  end

 def update
  @other_challan = OtherChallan.find(params[:id])
  respond_to do |format|
    if @other_challan.update(other_challan_params)
      format.html { redirect_to invoice_path, notice: 'invoice was successfully updated.' }
      format.json { render :index, status: :ok, location: @other_challan }
    else
      format.html { render :edit }
      format.json { render json: @other_challan.errors, status: :unprocessable_entity }
    end
  end
end

def destroy
  @other_challan = OtherChallan.find(params[:id])
  @other_challan.destroy
  flash[:notice] = "Successfully destroyed Invoice"
  redirect_to @other_challan
end

def show
  @other_challan = OtherChallan.find(params[:id])
  respond_to do |format|
    format.html
    format.pdf do
        render pdf: "show_other_challan.pdf.erb",
        orientation: 'Landscape'  # Excluding ".pdf" extension.
      end
    end
  end

  def show_other_challan
   @other_challan = OtherChallan.find(params[:id])
   respond_to do |format|
    format.html
    format.pdf do
        render pdf: "show_other_challan.pdf.erb", 
        orientation: 'Landscape'  # Excluding ".pdf" extension.
      end
    end
  end
  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def other_challan_params
      params.require(:other_challan).permit(:to_whom,:nature_of_processing, :state, :challan_no, :challan_date,other_challan_items_attributes:[ :item_id, :taxable_value,:integrated_tax_rate, :central_tax_rate, :state_tax_rate, :cess, :unit_price,:total_amt, :quantity, :_destroy])
    end
end
