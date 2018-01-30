class ReportsController < ApplicationController
def new
end

def export_excels
  if params[:gstr_type]=="GSTR1"
    @results = current_user.invoices
    @export_invoices = current_user.export_invoices
    @exempt_invoices = current_user.exempt_invoices
    @issue_notes = current_user.issue_notes
    @items = current_user.items
    book = Spreadsheet::Workbook.new
    sheet1 = book.create_worksheet :name => 'b2b'
    sheet2 = book.create_worksheet :name => 'b2cl'
    sheet3 = book.create_worksheet :name => 'b2cs'
    sheet4 = book.create_worksheet :name => 'cdnr'
    sheet5 = book.create_worksheet :name => 'cdnur'
    sheet6 = book.create_worksheet :name => 'exp'
    sheet7 = book.create_worksheet :name => 'exempt'
    sheet8 = book.create_worksheet :name => 'hsn'
    sheet1.row(0).height = 18
    format = Spreadsheet::Format.new :color => :blue, :weight => :bold, :size => 9, :right_color => :red
    sheet1.row(1).default_format = format
    sheet1.row(1).push "GSTIN/UIN of Recipient", "Invoice Number", "Invoice date", "Invoice Value", "Place Of Supply","Reverse Charge", "Invoice Type", "E-Commerce GSTIN", "Rate","Taxable Value", "Cess Amount"
    invoicetest = 0
    customer1 = 0
    total_invoices = 0
    @results.each_with_index do |r, i|
      if r.date.between?(params[:start_date].to_date ,params[:end_date].to_date) && params[:gstr_type] == 'GSTR1'
          if r.gstr_holder == 'GST HOLDER(B2B SUPPLY)'
              sheet1.insert_row(sheet1.last_row_index + 1, ["#{r.customer.gstin_no_reg}", "#{r.invoice_no}", "#{r.date}","#{r.invoice_value}", "#{r.customer.address}", "#{r.rcm}","Regular","#{r.ebay_bill_no}","#{r.tax_rate}","#{r.invoice_value}","#{r.total_invoice_value}"])
                  if r.invoice_value.blank?
                    r.invoice_value = 0
                  end
                 invoicetest = invoicetest + r.invoice_value.to_i
                 customer1 = customer1 + r.customer_id.to_i
                 total_invoices = total_invoices + r.invoice_no.to_i
          end
      end
    end
    sheet1.row(0).push "Total Receipient","#{customer1}","Total Invoice Value","#{invoicetest}"
    sheet2.row(0).push "Invoice Number", "Invoice date", "Invoice Value", "Place of Supply", "Rate", "Taxable Value","Cess Amount", "E-Commerce GSTIN"
    sheet2.row(0).default_format = format
    @results.each_with_index do |r, i|
          if r.date.between?(params[:start_date].to_date, params[:end_date].to_date) && params[:gstr_type] == 'GSTR1'
              if r.gstr_holder == 'GST HOLDER(OUT OF STATE)'
                sheet2.insert_row(sheet2.last_row_index + 1,["#{r.invoice_no}", "#{r.date}","#{r.invoice_value}", "#{r.customer.address}","#{r.tax_rate}","#{r.invoice_value}","#{r.total_invoice_value}"])
              end
          end
    end
    sheet3.row(0).push "Type", "Place of Supply", "Rate", "Taxable Value", "Cess Amount", "E-Commerce GSTIN"
    sheet3.row(0).default_format = format
    @results.each_with_index do |r, i|
          if r.date.between?(params[:start_date].to_date, params[:end_date].to_date) && params[:gstr_type] == 'GSTR1' 
              if r.gstr_holder == 'NON GST HOLDER(WITHIN STATE)'
                sheet3.insert_row(sheet3.last_row_index + 1,["OE", "#{r.customer.address}" ,"#{r.invoice_value}","#{r.tax_rate}","#{r.invoice_value}","#{r.total_invoice_value}","#{r.ebay_bill_no}"])
              end
          end
    end
    sheet4.row(0).push "GSTIN/UIN of Recipient", "Invoice/Advance Receipt Number", "Invoice/Advance Receipt date", "Note/Refund Voucher Number", "Note/Refund Voucher date", "Document Type", "Reason For Issuing document", "Place Of Supply", "Note/Refund Voucher Value", "Rate", "Taxable Value","Cess Amount", "Pre GST"
    sheet4.row(0).default_format = format
    @issue_notes.each_with_index do |r,i|
          if r.date_of_original_invoice.between?(params[:start_date].to_date, params[:end_date].to_date) && params[:gstr_type] == 'GSTR1'
              if r.register_type == "Registered"
                sheet4.insert_row(sheet4.last_row_index + 1, [ "#{r.customer.gstin_no_reg}" ,"#{r.invoice_no}", "#{r.date_of_original_invoice}","#{r.invoice_no}","#{r.date_of_issue_note}","#{r.document_type}","#{r.reason_for_issuing_note}","#{r.place_of_supply}","","#{r.tax_rate}","#{r.invoice_value}","#{r.total_invoice_value}","#{r.pre_gst}"])
              end
          end
    end
    sheet5.row(0).default_format = format
    sheet5.row(0).push "UR Type", "Note/Refund Voucher Number", "Document Type", "Invoice/Advance Receipt Number", "Invoice/Advance Receipt date", "Reason For Issuing document", "Place Of Supply", "Note/Refund Voucher Value","Rate", "Taxable Value", "Cess Amount", "Pre GST"
     @issue_notes.each_with_index do |r,i|
          if r.date_of_original_invoice.between?(params[:start_date].to_date, params[:end_date].to_date) && params[:gstr_type] == 'GSTR1'
              if r.register_type == "Non-Registered"
                sheet5.insert_row(sheet5.last_row_index + 1, ["#{r.ur_types}", "#{r.issue_note_no}","#{r.document_type}","#{r.invoice_no}","#{r.date_of_original_invoice}", "#{r.reason_for_issuing_note}","#{r.place_of_supply}","","#{r.tax_rate}","#{r.invoice_value}","#{r.total_invoice_value}","#{r.pre_gst}"])
              end
          end
    end
    sheet6.row(0).default_format = format
    sheet6.row(0).push "Export Type", "Invoice Number", "Invoice date", "Invoice Value", "Port Code", "Shipping Bill Number", "Shipping Bill Date", "Rate", "Taxable Value"
      @export_invoices.each_with_index do |r,i|
              if r.export_invoice_date.between?(params[:start_date].to_date, params[:end_date].to_date) && params[:gstr_type] == 'GSTR1'
                sheet6.insert_row(sheet6.last_row_index + 1, [ "#{r.export_type}" ,"#{r.export_invoice_number}", "#{r. export_invoice_date}","","","","","#{r.invoice_value}","#{r.export_invoice_value}"])
              
    end
    end
    sheet7.row(0).default_format = format
    sheet7.row(0).push "Description", "Nil Rated Supplies", "Exempted (other than nil rated/non GST supply )", "Non-GST supplies"

    sheet8.row(0).default_format = format
    sheet8.row(0).push  "HSN", "Description", "UQC", "Total Quantity", "Total Value", "Taxable Value", "Integrated Tax Amount", "Central Tax Amount", "State/UT Tax Amount", "Cess Amount"
    @items.each_with_index do |r,i|
              if params[:gstr_type] == 'GSTR1'
                sheet8.insert_row(sheet8.last_row_index + 1, ["#{r.item_hsn_no}", "#{r.dogns}", "#{r.unit_of_measure.name}"])
              end         
    end
    spreadsheet = StringIO.new
    book.write spreadsheet
    file = "Excelsheet"
    send_data spreadsheet.string, :filename => "#{file}", :type =>  "application/vnd.ms-excel"
    end

    if params[:gstr_type]=="GSTR2"
    @results = current_user.purchase_bills
    @export_invoices = current_user.export_purchase_bills
    @exempt_invoices = current_user.nillrate_exempt_bills
    @purchase_bills = current_user.purchase_bills

    @issue_notes = current_user.credit_debit_notes
    @items = current_user.items
    book = Spreadsheet::Workbook.new
    sheet1 = book.create_worksheet :name => 'b2b'
    sheet2 = book.create_worksheet :name => 'b2cl'
    sheet3 = book.create_worksheet :name => 'b2cs'
    sheet4 = book.create_worksheet :name => 'cdnr'
    sheet5 = book.create_worksheet :name => 'cdnur'
    sheet6 = book.create_worksheet :name => 'exp'
    sheet7 = book.create_worksheet :name => 'exempt'
    sheet8 = book.create_worksheet :name => 'hsn'

    sheet1.row(0).height = 18
    format = Spreadsheet::Format.new :color => :blue, :weight => :bold, :size => 9, :right_color => :red
    sheet1.row(1).default_format = format
    sheet1.row(1).push "GSTIN/UIN of Recipient", "Invoice Number", "Invoice date", "Invoice Value", "Place Of Supply","Reverse Charge", "Invoice Type", "E-Commerce GSTIN", "Rate","Taxable Value"
    invoicetest = 0
    customer1 = 0
    total_invoices = 0

    @results.each_with_index do |r, i|
      if r.date.between?(params[:start_date].to_date ,params[:end_date].to_date) && params[:gstr_type] == 'GSTR2'
          if r.bill_type == 'b2b'
              sheet1.insert_row(sheet1.last_row_index + 1, ["#{r.customer.gstin_no_reg}", "#{r.purchase_no}", "#{r.date}","#{r.invoice_value}", "#{r.customer.address}","Regular","#{r.tax_rate}","#{r.invoice_value}"])
                  if r.invoice_value.blank?
                    r.invoice_value = 0
                  end
                 invoicetest = invoicetest + r.invoice_value.to_i
                 customer1 = customer1 + r.customer_id.to_i
                 total_invoices = total_invoices + r.purchase_no.to_i
          end

          if r.bill_type == 'b2cl'
              sheet2.insert_row(sheet1.last_row_index + 1, ["#{r.customer.gstin_no_reg}", "#{r.purchase_no}", "#{r.date}","#{r.invoice_value}", "#{r.customer.address}","Regular","#{r.tax_rate}","#{r.invoice_value}"])
                  if r.invoice_value.blank?
                    r.invoice_value = 0
                  end
                 invoicetest = invoicetest + r.invoice_value.to_i
                 customer1 = customer1 + r.customer_id.to_i
                 total_invoices = total_invoices + r.purchase_no.to_i
          end

          if r.bill_type == 'b2cs'
              sheet3.insert_row(sheet1.last_row_index + 1, ["#{r.customer.gstin_no_reg}", "#{r.purchase_no}", "#{r.date}","#{r.invoice_value}","#{r.tax_rate}","#{r.invoice_value}","#{r.total_invoice_value}"])
                  if r.invoice_value.blank?
                    r.invoice_value = 0
                  end
                 invoicetest = invoicetest + r.invoice_value.to_i
                 customer1 = customer1 + r.customer_id.to_i
                 total_invoices = total_invoices + r.purchase_no.to_i
          end
      end
    end

    sheet1.row(0).push "Total Receipient","#{customer1}","Total Invoice Value","#{invoicetest}"
    sheet2.row(0).push "Invoice Number", "Invoice date", "Invoice Value", "Place of Supply", "Rate", "Taxable Value","Cess Amount", "E-Commerce GSTIN"
    sheet2.row(0).default_format = format
    @results.each_with_index do |r, i|
          if r.date.between?(params[:start_date].to_date, params[:end_date].to_date) && params[:gstr_type] == 'GSTR2'
              if r.bill_type == 'GST HOLDER(OUT OF STATE)'
                sheet2.insert_row(sheet2.last_row_index + 1,["#{r.purchase_no}", "#{r.date}","#{r.invoice_value}", "#{r.customer.address}","#{r.tax_rate}","#{r.invoice_value}","#{r.total_invoice_value}"])
              end
          end
    end

    sheet3.row(0).push "Type", "Place of Supply", "Rate", "Taxable Value", "Cess Amount", "E-Commerce GSTIN"
    sheet3.row(0).default_format = format
    @results.each_with_index do |r, i|
          if r.date.between?(params[:start_date].to_date, params[:end_date].to_date) && params[:gstr_type] == 'GSTR2' 
              if r.bill_type == 'NON GST HOLDER(WITHIN STATE)'
                sheet3.insert_row(sheet3.last_row_index + 1,["OE", "#{r.customer.address}" ,"#{r.invoice_value}","#{r.tax_rate}","#{r.invoice_value}","#{r.total_invoice_value}"])
              end
          end
    end

    sheet4.row(0).push "GSTIN/UIN of Recipient", "Invoice/Advance Receipt Number", "Invoice/Advance Receipt date", "Note/Refund Voucher Number", "Note/Refund Voucher date", "Document Type", "Reason For Issuing document", "Place Of Supply", "Note/Refund Voucher Value", "Rate", "Taxable Value","Cess Amount", "Pre GST"
    sheet4.row(0).default_format = format
    @issue_notes.each_with_index do |r,i|
          if r.date_of_original_invoice.between?(params[:start_date].to_date, params[:end_date].to_date) && params[:gstr_type] == 'GSTR2'
              if r.register_type == "Registered"
                sheet4.insert_row(sheet4.last_row_index + 1, [ "#{r.customer.gstin_no_reg}" ,"#{r.invoice_no}", "#{r.date_of_original_invoice}","#{r.invoice_no}","#{r.date_of_issue_note}","#{r.document_type}","#{r.reason_for_issuing_note}","#{r.place_of_supply}","","#{r.invoice_value}","#{r.total_invoice_value}","#{r.pre_gst}"])
              end
          end
    end

    sheet5.row(0).default_format = format
    sheet5.row(0).push "UR Type", "Note/Refund Voucher Number", "Document Type", "Invoice/Advance Receipt Number", "Invoice/Advance Receipt date", "Reason For Issuing document", "Place Of Supply", "Note/Refund Voucher Value","Rate", "Taxable Value", "Cess Amount", "Pre GST"
     @issue_notes.each_with_index do |r,i|
          if r.date_of_original_invoice.between?(params[:start_date].to_date, params[:end_date].to_date) && params[:gstr_type] == 'GSTR2'
              if r.register_type == "Non-Registered"
                sheet5.insert_row(sheet5.last_row_index + 1, ["#{r.ur_types}", "#{r.issue_note_no}","#{r.document_type}","#{r.invoice_no}","#{r.date_of_original_invoice}", "#{r.reason_for_issuing_note}","#{r.place_of_supply}","","#{r.invoice_value}","#{r.total_invoice_value}","#{r.pre_gst}"])
              end
          end
    end

    sheet7.row(0).default_format = format
    sheet7.row(0).push "Description", "Nil Rated Supplies", "Exempted (other than nil rated/non GST supply )", "Non-GST supplies"

    sheet8.row(0).default_format = format
    sheet8.row(0).push  "HSN", "Description", "UQC", "Total Quantity", "Total Value", "Taxable Value", "Integrated Tax Amount", "Central Tax Amount", "State/UT Tax Amount", "Cess Amount"
    @items.each_with_index do |r,i|
          if params[:gstr_type] == 'GSTR2'
            sheet8.insert_row(sheet8.last_row_index + 1, ["#{r.item_hsn_no}", "#{r.dogns}", "#{r.unit_of_measure.name}"])
          end         
    end

    spreadsheet = StringIO.new
    book.write spreadsheet
    file = "Excelsheet"
    send_data spreadsheet.string, :filename => "#{file}", :type =>  "application/vnd.ms-excel"
    end
  end

  def excel_lists
    @start_date = params[:report][:start_date].to_date
    @end_date = params[:report][:end_date].to_date
    @gstr_type = params[:report][:gstr_type]
      if @start_date.nil? || @end_date.nil?
        flash[:alert] = 'Done'
        render 'new'
      end
    end


    def composite_report
    end
    
    def composite_excels
      @start_date = params[:report][:start_date].to_date
      @end_date = params[:report][:end_date].to_date
      @gstr_type = params[:report][:gstr_type]
        if @start_date.nil? || @end_date.nil?
          flash[:alert] = 'Done'
          render 'composite_report'
        end
    end

    def composite_export_excels
      @results = current_user.composite_cd_notes
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
      # @results.each_with_index do |r, i|
      #   if r.date.between?(params[:start_date].to_date ,params[:end_date].to_date) && params[:gstr_type] == 'GSTR1'
      #       if r.gstr_holder == 'GST HOLDER(B2B SUPPLY)'
      #           sheet1.insert_row(sheet1.last_row_index + 1, ["#{r.customer.gstin_no_reg}", "#{r.invoice_no}", "#{r.date}","#{r.invoice_value}", "#{r.customer.address}", "#{r.rcm}","Regular","#{r.ebay_bill_no}","#{r.tax_rate}","#{r.invoice_value}","#{r.total_invoice_value}"])
      #               if r.invoice_value.blank?
      #                 r.invoice_value = 0
      #               end
      #              invoicetest = invoicetest + r.invoice_value.to_i
      #              customer1 = customer1 + r.customer_id.to_i
      #              total_invoices = total_invoices + r.invoice_no.to_i
      #       end
      #   end
      # end
      # sheet1.row(0).push "Total Receipient","#{customer1}","Total Invoice Value","#{invoicetest}"
  end
end