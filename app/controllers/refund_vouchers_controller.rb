class RefundVouchersController < ApplicationController
	
	def index
		if current_user.role =- 'Party'
		 @refund_vouchers = current_user.refund_vouchers
		else
		@refund_vouchers = RefundVoucher.all
		end
	end

	def new
	    @refund_voucher = RefundVoucher.new
	     @item = Item.new
        @unit_of_measure = UnitOfMeasure.new
	    @refund_voucher.refund_voucher_items.build # build ingredient attributes, nothing new here
	    # @refund_voucher.voucher_no = RefundVoucher.set_refund_voucher_no
	    @items = Item.all
	end

	def create
		@refund_voucher = RefundVoucher.new(refund_voucher_params)
	     @user = current_user
	    if @refund_voucher.save
	        @refund_voucher.update!(user_id: @user.id)
	      flash[:notice] = "Successfully Created refund_voucher"
	      redirect_to @refund_voucher and return
	  end
	end

	def edit
		@refund_voucher = RefundVoucher.find(params[:id])
	end

	def update
		@refund_voucher = RefundVoucher.find(params[:id])
		respond_to do |format|
			if @refund_voucher.update(refund_voucher_params)
				@refund_voucher.assign_attributes(id: params[:id])
				format.html { redirect_to refund_voucher_path, notice: 'refund_voucher was successfully updated.' }
				format.json { render :index, status: :ok, location: @refund_voucher }
			else
				format.html { render :edit }
				format.json { render json: @refund_voucher.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@refund_voucher = RefundVoucher.find(params[:id])
		@refund_voucher.destroy
		flash[:notice] = "Successfully destroyed refund_voucher"
		redirect_to @refund_voucher
	end

	def show
		@refund_voucher = RefundVoucher.find(params[:id])
		respond_to do |format|
			format.html
			format.pdf do
	        render pdf: "show_refund_voucher.pdf.erb", 
	        orientation: 'Landscape' # Excluding ".pdf" extension.
	    end
	end
	end


	def show_refund_voucher
		@refund_voucher = RefundVoucher.find(params[:id])
		respond_to do |format|
			format.html
			format.pdf do
	        render pdf: "show_refund_voucher.pdf.erb",  
	        orientation: 'Landscape' # Excluding ".pdf" extension.
	    end
	end
	end


	private

	def refund_voucher_params
		params.require(:refund_voucher).permit(:customer_id,:check_n ,:debit_acc_no,:to_whom,:against,:date,:voucher_no,:cash_or_check,refund_voucher_items_attributes:[:id,:details,:amount])
	end
end
