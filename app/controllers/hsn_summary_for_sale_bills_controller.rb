class HsnSummaryForSaleBillsController < ApplicationController
	def index
		@hsn_summaries = HsnSummaryForSaleBill.order(:description)
		 respond_to do |format|
        format.html
        format.csv { send_data @hsn_summaries.to_csv }
        format.xls { send_data @hsn_summaries.to_csv(col_sep: "\t") }
        end
	end

	private

	def hsn_summary_for_sale_bill_params
		params.require(:hsn_summary_for_sale_bill).permit(:cess)
	end
end
