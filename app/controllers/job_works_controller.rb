class JobWorksController < ApplicationController
	def index
    if current_user.role == 'Party'
      @job_works = current_user.job_works
    else
      @job_works = JobWork.all
    end
  end

  def new
    @job_work = JobWork.new
    @item = Item.new
    @unit_of_measure = UnitOfMeasure.new
    @job_work.job_work_items.build # build ingredient attributes, nothing new here
    @job_work.challan_no = JobWork.set_invoice_no
    @items = Item.all
  end

  def create
    @job_work = JobWork.new(job_work_params)
    @user = current_user
    if @job_work.save
      @job_work.update!(user_id: @user.id)
      flash[:notice] = "Successfully Created Invoice"
      redirect_to @job_work and return
    end
  end

  def edit
   @job_work = JobWork.find(params[:id])
 end

 def update
  @job_work = JobWork.find(params[:id])
  respond_to do |format|
    if @job_work.update(job_work_params)
      format.html { redirect_to invoice_path, notice: 'invoice was successfully updated.' }
      format.json { render :index, status: :ok, location: @job_work }
    else
      format.html { render :edit }
      format.json { render json: @job_work.errors, status: :unprocessable_entity }
    end
  end
end

def destroy
  @job_work = JobWork.find(params[:id])
  @job_work.destroy
  flash[:notice] = "Successfully destroyed Invoice"
  redirect_to @job_work
end

def show
  @job_work = JobWork.find(params[:id])
  respond_to do |format|
    format.html
    format.pdf do
        render pdf: "show_job_work.pdf.erb",
        orientation: 'Landscape'   # Excluding ".pdf" extension.
      end
    end
  end

  def show_job_work
   @job_work = JobWork.find(params[:id])
   respond_to do |format|
    format.html
    format.pdf do
        render pdf: "show_job_work.pdf.erb",
        orientation: 'Landscape'  # Excluding ".pdf" extension.
      end
    end
  end
  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def job_work_params
      params.require(:job_work).permit(:customer_id, :nature_of_processing,:gstin_of_job_worker,:e_way_bill_no, :transportation_mode, :vehicle_no,:gstin_of_job_worker, :state, :challan_no, :challan_date,job_work_items_attributes:[ :item_id, :taxable_value, :types_of_goods, :integrated_tax_rate, :central_tax_rate, :state_tax_rate, :cess, :unit_price,:total_amt, :quantity, :_destroy])
    end
end