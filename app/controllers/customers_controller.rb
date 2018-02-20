class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  # GET /customers
  # GET /customers.json
  def index
    if current_user.role == 'Party'
     @customers = current_user.customers
    else
    @customers = Customer.all
    end
  end

  def load_customer_data
    @customer = Customer.find_by_id(params[:customer_id]).present? ? Customer.find(params[:customer_id]) : Customer.unscoped.find_by_id(params[:customer_id])
    render :json => [ @customer.address, @customer.gstin_no_reg, @customer.cust_pan_no,@customer.cust_place_of_supply]
  end

  # GET /customers/1
  # GET /customers/1.json
  def show
  end

  # GET /customers/new
  def new
    @customer = Customer.new
  end

  # GET /customers/1/edit
  def edit
  end

  # POST /customers
  # POST /customers.json
  def create
   
    @customer = Customer.new(customer_params)
    @user = current_user
      respond_to do |format|
      if @customer.save
        @customer.update!(user_id: @user.id)
        format.html { redirect_to @customer, notice: 'Customer was successfully created.' }
        format.json { render :show, status: :created, location: @customer }
      else
        format.html { render :new }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customers/1
  # PATCH/PUT /customers/1.json
  def update
    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to @customer, notice: 'Customer was successfully updated.' }
        format.json { render :show, status: :ok, location: @customer }
      else
        format.html { render :edit }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    @customer.destroy
    respond_to do |format|
      format.html { redirect_to customers_url, notice: 'Customer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_params
      params.require(:customer).permit(:customer_type,:customer_name, :gstin_no_reg, :arn_no, :address, :cust_place_of_supply, :cust_name_of_commodity_supplied,
       :cust_tarrif_no, :cust_rate_of_tax, :cust_name_of_service, :cust_serv_acc_code, :cust_pan_no,item_attributes:[:dogns, :item_hsn_no, :uom, :qty,:rate,:taxable_value])
    end
end
