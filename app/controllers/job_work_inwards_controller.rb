class JobWorkInwardsController < ApplicationController
  def index
    if current_user.role == 'Party'
      @job_work_inwards = current_user.job_work_inwards
    else
      @job_work_inwards = JobWorkInward.all
    end
  end

  def new
    @job_work_inward = JobWorkInward.new
    @item = Item.new
    @unit_of_measure = UnitOfMeasure.new
    @job_work_inward.job_work_inward_items.build # build ingredient attributes, nothing new here
    @items = Item.all
  end

  def create
    @job_work_inward = JobWorkInward.new(job_work_inward_params)
    @user = current_user
    if @job_work_inward.save
      @job_work_inward.update!(user_id: @user.id)
      flash[:notice] = "Successfully Created Invoice"
      redirect_to @job_work_inward and return
    end
  end

  def edit
   @job_work_inward = JobWorkInward.find(params[:id])
  end

 def update
  @job_work_inward = JobWorkInward.find(params[:id])
  respond_to do |format|
    if @job_work_inward.update(job_work_inward_params)
      format.html { redirect_to invoice_path, notice: 'invoice was successfully updated.' }
      format.json { render :index, status: :ok, location: @job_work_inward }
    else
      format.html { render :edit }
      format.json { render json: @job_work_inward.errors, status: :unprocessable_entity }
    end
  end
end

def destroy
  @job_work_inward = JobWorkInward.find(params[:id])
  @job_work_inward.destroy
  flash[:notice] = "Successfully destroyed Invoice"
  redirect_to @job_work_inward
end

def show
  @job_work_inward = JobWorkInward.find(params[:id])
  respond_to do |format|
    format.html
    format.pdf do
        render pdf: "show_job_work_inward.pdf.erb",
        orientation: 'Landscape'   # Excluding ".pdf" extension.
      end
    end
  end

  def show_job_work_inward
   @job_work_inward = JobWorkInward.find(params[:id])
   respond_to do |format|
    format.html
    format.pdf do
        render pdf: "show_job_work_inward.pdf.erb"# Excluding ".pdf" extension.
      end
    end
  end
  
  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def job_work_inward_params
      params.require(:job_work_inward).permit(:nature_of_processing, :nature_of_transaction,:e_way_bill_no, :transportation_mode, :vehicle_no,:gstin_of_job_worker, :state, :challan_no, :challan_date,job_work_inward_items_attributes:[ :item_id, :taxable_value, :types_of_goods, :integrated_tax_rate, :central_tax_rate, :state_tax_rate, :cess, :unit_price,:total_amt, :quantity, :_destroy])
    end
end
