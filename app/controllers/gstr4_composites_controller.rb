class Gstr4CompositesController < ApplicationController
    def new
    end

    def export
    @results = current_user.b2b_composites
    @results1 = current_user.composite_cd_notes

        book = Spreadsheet::Workbook.new
        sheet1 = book.create_worksheet :name => '4B(B2B)'
        sheet2 = book.create_worksheet :name => '4C(B2BUR)'
        sheet3 = book.create_worksheet :name => '4D(IMPS)'
        sheet4 = book.create_worksheet :name => '5B(CDNR)'
        sheet5 = book.create_worksheet :name => '5B(CDNUR)'
        sheet1.row(0).height = 18
        format = Spreadsheet::Format.new :color => :blue, :weight => :bold, :size => 9, :right_color => :red
        sheet1.row(1).default_format = format
        sheet1.row(1).push "GSTIN/UIN of Supplier", "Invoice Number", "Invoice date", "Invoice Value", "Place Of Supply","Reverse Charge", "Invoice Type", "Rate","Integrated Tax", "Central Tax", "State/UT Tax","Taxable Value", "Cess Amount"
          @results.each_with_index do |r, i|  
          if r.invoice_date.between?(params[:start_date].to_date , params[:end_date].to_date) && params[:gstr_type] == 'GSTR4'
            if r.invoice_type == '4B(B2B)'
                sheet1.insert_row(sheet1.last_row_index + 1, ["#{r.customer.gstin_no_reg}", "#{r.invoice_number}", "#{r.invoice_date}","#{r.b2b_composite_value}","#{r.customer.cust_place_of_supply}", "#{r.rcm}", "#{r.invoice_type}","#{r.tax_rate}","#{r.igst}","#{r.cgst}","#{r.sgst}","#{r.total_b2b_composite_value}","#{r.cess}"])
            end
          end
        end

        format = Spreadsheet::Format.new :color => :blue, :weight => :bold, :size => 9, :right_color => :red
        sheet2.row(2).default_format = format
        sheet2.row(2).push "Invoice Number", "Invoice date", "Invoice Value", "Place Of Supply","Supply Type","Rate","Taxable Value","Integrated Tax", "Central Tax", "State/UT Tax", "Cess"
          @results.each_with_index do |r, i|  
          if r.invoice_date.between?(params[:start_date].to_date , params[:end_date].to_date) && params[:gstr_type] == 'GSTR4'
            if r.invoice_type == '4C(B2BUR)'
                sheet2.insert_row(sheet2.last_row_index + 1, ["#{r.invoice_number}", "#{r.invoice_date}","#{r.b2b_composite_value}","#{r.customer.cust_place_of_supply}", "#{r.supply_type}", "#{r.tax_rate}","#{r.igst}","#{r.cgst}","#{r.sgst}","#{r.total_b2b_composite_value}","#{r.cess}"])
            end
          end
        end


        format = Spreadsheet::Format.new :color => :blue, :weight => :bold, :size => 9, :right_color => :red
        sheet3.row(2).default_format = format
        sheet3.row(2).push "Invoice Number", "Invoice date", "Invoice Value", "Place Of Supply","Rate","Taxable Value","Integrated Tax", "Cess"
          @results.each_with_index do |r, i|  
          if r.invoice_date.between?(params[:start_date].to_date , params[:end_date].to_date) && params[:gstr_type] == 'GSTR4'
            if r.invoice_type == '4D(IMPS)'
                sheet3.insert_row(sheet3.last_row_index + 1, ["#{r.invoice_number}", "#{r.invoice_date}","#{r.b2b_composite_value}","#{r.customer.cust_place_of_supply}", "#{r.tax_rate}","#{r.igst}","#{r.cgst}","#{r.sgst}","#{r.total_b2b_composite_value}","#{r.cess}"])
            end
          end
        end


        format = Spreadsheet::Format.new :color => :blue, :weight => :bold, :size => 9, :right_color => :red
        sheet4.row(2).default_format = format
        sheet4.row(2).push "GSTIN of Supplier","Note/Refund Voucher Number", "Note/Refund Voucher date", "Invoice/Payment Voucher Number","Invoice/Payment Voucher Date","Pre GST","Document Type", "Reason For Issuing Document", "Supply Type","Reverse Charge", "Note/Refund Voucher Value","Rate","Taxable Value","Integrated Tax", "Central Tax", "State/UT Tax", "Cess"
          @results1.each_with_index do |r, i|  
          if r.refund_voucher_date.to_date.between?(params[:start_date].to_date , params[:end_date].to_date) && params[:gstr_type] == 'GSTR4'
            if r.register_type == 'Registered'
                sheet4.insert_row(sheet4.last_row_index + 1, ["#{r.refund_voucher_number}", "#{r.refund_voucher_date}","#{r.payment_voucher_number}","", "pregst","#{r.document_type}","#{r.reason_for_issuing_document}","#{r.supply_type}","#{r.reverse_charge}","#{r.refund_voucher_value}","#{r.rate}","#{r.taxable_value}","#{r.igst}","#{r.cgst}","#{r.sgst}","#{r.cess}"])
            end
          end
        end


        format = Spreadsheet::Format.new :color => :blue, :weight => :bold, :size => 9, :right_color => :red
        sheet5.row(2).default_format = format
        sheet5.row(2).push "Note/Refund Voucher Number", "Note/Refund Voucher date", "Invoice/Advance Payment Voucher Number","Invoice/Advance Payment Voucher Date","Pre GST","Document Type", "Reason For Issuing Document", "Supply Type","Inward Supply Type", "Note/Refund Voucher Value","Rate","Taxable Value","Integrated Tax", "Central Tax", "State/UT Tax", "Cess"
          @results1.each_with_index do |r, i|  
          if r.refund_voucher_date.to_date.between?(params[:start_date].to_date , params[:end_date].to_date) && params[:gstr_type] == 'GSTR4'
            if r.register_type == 'Non-Registered'
                sheet5.insert_row(sheet5.last_row_index + 1, ["#{r.refund_voucher_number}", "#{r.refund_voucher_date}","#{r.payment_voucher_number}","", "pregst","#{r.document_type}","#{r.reason_for_issuing_document}","#{r.supply_type}","#{r.reverse_charge}","#{r.refund_voucher_value}","#{r.rate}","#{r.taxable_value}","#{r.igst}","#{r.cgst}","#{r.sgst}","#{r.cess}"])
            end
          end
        end


          spreadsheet = StringIO.new
          book.write spreadsheet
          file = "Excelsheet"
          send_data spreadsheet.string, :filename => "#{file}", :type =>  "application/vnd.ms-excel"
end

    def excel_lists
        @start_date = params[:gstr4_composites][:start_date].to_date
        @end_date = params[:gstr4_composites][:end_date].to_date
        @gstr_type = params[:gstr4_composites][:gstr_type]
          if @start_date.nil? || @end_date.nil?
            flash[:alert] = 'Done'
            render 'new'
          end
    end
    
end
