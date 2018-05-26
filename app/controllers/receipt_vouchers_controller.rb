class ReceiptVouchersController < ApplicationController
	def index
		if current_user.role == 'Party'
			@receipt_vouchers = current_user.receipt_vouchers
		else
			@receipt_vouchers = ReceiptVoucher.all
		end
	end

	def new
	    @receipt_voucher = ReceiptVoucher.new
	    @item = Item.new
        @unit_of_measure = UnitOfMeasure.new
	    @receipt_voucher.receipt_voucher_items.build # build ingredient attributes, nothing new here
	    @receipt_voucher.voucher_no = ReceiptVoucher.set_receipt_voucher_no
	    @items = Item.all
	end

	def create
		@receipt_voucher = ReceiptVoucher.new(receipt_voucher_params)
	     @user = current_user
	    if @receipt_voucher.save
	      @receipt_voucher.update!(user_id: @user.id)
	      flash[:notice] = "Successfully Created receipt_voucher"
	      redirect_to @receipt_voucher and return
	  end
	end

	def edit
		@receipt_voucher = ReceiptVoucher.find(params[:id])
	end

	def update
		@receipt_voucher = ReceiptVoucher.find(params[:id])
		respond_to do |format|
			if @receipt_voucher.update(receipt_voucher_params)
			    @receipt_voucher.assign_attributes(id: params[:id])
				format.html { redirect_to receipt_voucher_path, notice: 'receipt_voucher was successfully updated.' }
				format.json { render :index, status: :ok, location: @receipt_voucher }
			else
				format.html { render :edit }
				format.json { render json: @receipt_voucher.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@receipt_voucher = ReceiptVoucher.find(params[:id])
		@receipt_voucher.destroy
		flash[:notice] = "Successfully destroyed receipt_voucher"
		redirect_to @receipt_voucher
	end

	def show
		@receipt_voucher = ReceiptVoucher.find(params[:id])
		respond_to do |format|
			format.html
			format.pdf do
	        render pdf: "show_receipt_voucher.pdf.erb" ,
	        orientation: 'Landscape'  # Excluding ".pdf" extension.
	    end
	end
	end


	def show_receipt_voucher
		@receipt_voucher = ReceiptVoucher.find(params[:id])
		respond_to do |format|
			format.html
			format.pdf do
	        render pdf: "show_receipt_voucher.pdf.erb" ,  
	        orientation: 'Landscape'# Excluding ".pdf" extension.
	    end
	end
	end


	private

	def receipt_voucher_params
		params.require(:receipt_voucher).permit( :check_no,:customer_id,:debit_acc_no,:to_whom,:against,:date,:voucher_no,:cash_or_check,receipt_voucher_items_attributes:[:id,:details,:amount])
	end
end
