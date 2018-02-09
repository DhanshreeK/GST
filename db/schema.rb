# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180116102939) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "b2b_composite_items", force: :cascade do |t|
    t.bigint "b2b_composite_id"
    t.bigint "item_id"
    t.string "quantity"
    t.string "net_amt"
    t.string "tax_rate"
    t.string "decimal"
    t.decimal "tax_amt"
    t.string "total_amt"
    t.string "item_descritption"
    t.string "unit_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["b2b_composite_id"], name: "index_b2b_composite_items_on_b2b_composite_id"
    t.index ["item_id"], name: "index_b2b_composite_items_on_item_id"
  end

  create_table "b2b_composites", force: :cascade do |t|
    t.string "gstin_of_supplier"
    t.string "invoice_number"
    t.date "invoice_date"
    t.string "place_of_supply"
    t.string "rcm"
    t.string "invoice_type"
    t.string "rate"
    t.string "taxable_value"
    t.string "igst"
    t.string "cgst"
    t.string "sgst"
    t.string "cess"
    t.bigint "customer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.string "b2b_composite_value"
    t.string "tax_rate"
    t.string "total_b2b_composite_value"
    t.index ["customer_id"], name: "index_b2b_composites_on_customer_id"
    t.index ["user_id"], name: "index_b2b_composites_on_user_id"
  end

  create_table "business_sales", force: :cascade do |t|
    t.date "invoice_date"
    t.string "serial_no"
    t.string "gstin_no"
    t.string "eway_bill"
    t.string "transportation_mode"
    t.string "vehicle_no"
    t.date "date"
    t.string "time_of_supply"
    t.string "place_of_supply"
    t.string "total_invoice"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "charted_accountants", force: :cascade do |t|
    t.string "name"
    t.string "phn_no"
    t.string "address"
    t.string "email"
    t.string "firm_name"
    t.string "ca_no"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.boolean "ca_status", default: false
  end

  create_table "composite_cd_note_items", force: :cascade do |t|
    t.bigint "composite_cd_note_id"
    t.bigint "item_id"
    t.string "quantity"
    t.string "string"
    t.string "net_amt"
    t.string "tax_rate"
    t.string "decimal"
    t.string "tax_amt"
    t.string "total_amt"
    t.string "item_descritption"
    t.string "unit_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["composite_cd_note_id"], name: "index_composite_cd_note_items_on_composite_cd_note_id"
    t.index ["item_id"], name: "index_composite_cd_note_items_on_item_id"
  end

  create_table "composite_cd_notes", force: :cascade do |t|
    t.bigint "customer_id"
    t.string "refund_voucher_number"
    t.string "refund_voucher_date"
    t.string "payment_voucher_number"
    t.string "pregst"
    t.string "document_type"
    t.string "reason_for_issuing_document"
    t.string "supply_type"
    t.string "reverse_charge"
    t.string "refund_voucher_value"
    t.string "rate"
    t.string "taxable_value"
    t.string "igst"
    t.string "sgst"
    t.string "cgst"
    t.string "cess"
    t.string "total_invoice_value"
    t.string "invoice_value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "advance_payment_voucher_number"
    t.date "advance_voaucher_date"
    t.string "inward_supply_type"
    t.bigint "user_id"
    t.string "register_type"
    t.string "note_type"
    t.index ["customer_id"], name: "index_composite_cd_notes_on_customer_id"
    t.index ["user_id"], name: "index_composite_cd_notes_on_user_id"
  end

  create_table "credit_debit_note_items", force: :cascade do |t|
    t.bigint "item_id"
    t.bigint "credit_debit_note_id"
    t.string "unit_price"
    t.string "quantity"
    t.string "rate"
    t.string "net_amt"
    t.string "sgst"
    t.string "cgst"
    t.string "tax_rate"
    t.string "tax_amt"
    t.string "total_amt"
    t.string "qty"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["credit_debit_note_id"], name: "index_credit_debit_note_items_on_credit_debit_note_id"
    t.index ["item_id"], name: "index_credit_debit_note_items_on_item_id"
  end

  create_table "credit_debit_notes", force: :cascade do |t|
    t.date "date_of_original_invoice"
    t.string "invoice_no"
    t.string "gstin_no"
    t.string "e_way_bill_no"
    t.string "date_of_issue_note"
    t.string "issue_note_no"
    t.string "pre_gst"
    t.string "place_of_supply"
    t.bigint "customer_id"
    t.string "reason_for_issuing_note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "register_type"
    t.string "note_type"
    t.bigint "user_id"
    t.string "invoice_value"
    t.string "cess"
    t.string "total_invoice_value"
    t.string "document_type"
    t.string "ur_types"
    t.index ["customer_id"], name: "index_credit_debit_notes_on_customer_id"
    t.index ["user_id"], name: "index_credit_debit_notes_on_user_id"
  end

  create_table "customer_items", force: :cascade do |t|
    t.integer "customer_id"
    t.integer "item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "invoice_date"
    t.string "serial_no"
    t.string "gstin_no"
    t.string "eway_bill"
    t.string "transportation_mode"
    t.string "vehicle_no"
    t.date "date"
    t.string "time_of_supply"
    t.string "place_of_supply"
    t.string "total_invoice"
    t.integer "invoice_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "customer_name"
    t.string "gstin_no_reg"
    t.string "arn_no"
    t.string "address"
    t.string "cust_place_of_supply"
    t.string "cust_name_of_commodity_supplied"
    t.string "cust_tarrif_no"
    t.string "cust_rate_of_tax"
    t.string "cust_name_of_service"
    t.string "cust_serv_acc_code"
    t.string "cust_pan_no"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "party_id"
    t.string "invoice_no"
    t.bigint "user_id"
    t.string "customer_type"
    t.index ["user_id"], name: "index_customers_on_user_id"
  end

  create_table "exempt_invoice_items", force: :cascade do |t|
    t.bigint "item_id"
    t.bigint "exempt_invoice_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "unit_price"
    t.string "quantity"
    t.string "rate"
    t.string "qty"
    t.string "net_amt"
    t.string "sgst"
    t.string "cgst"
    t.string "tax_rate"
    t.string "tax_amt"
    t.string "total_amt"
    t.index ["exempt_invoice_id"], name: "index_exempt_invoice_items_on_exempt_invoice_id"
    t.index ["item_id"], name: "index_exempt_invoice_items_on_item_id"
  end

  create_table "exempt_invoices", force: :cascade do |t|
    t.bigint "customer_id"
    t.string "exempt_invoice_number"
    t.date "exempt_invoice_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.string "exempt_invoice_value"
    t.string "pos"
    t.string "transportation_mode"
    t.string "vehicle_number"
    t.string "narration"
    t.string "terms_and_conditions"
    t.index ["customer_id"], name: "index_exempt_invoices_on_customer_id"
    t.index ["user_id"], name: "index_exempt_invoices_on_user_id"
  end

  create_table "export_invoice_items", force: :cascade do |t|
    t.bigint "item_id"
    t.bigint "export_invoice_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "unit_price"
    t.string "quantity"
    t.string "rate"
    t.string "qty"
    t.string "net_amt"
    t.string "sgst"
    t.string "cgst"
    t.string "tax_rate"
    t.string "tax_amt"
    t.string "total_amt"
    t.index ["export_invoice_id"], name: "index_export_invoice_items_on_export_invoice_id"
    t.index ["item_id"], name: "index_export_invoice_items_on_item_id"
  end

  create_table "export_invoices", force: :cascade do |t|
    t.bigint "customer_id"
    t.string "export_invoice_number"
    t.date "export_invoice_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.string "export_invoice_value"
    t.string "invoice_value"
    t.string "port_code"
    t.string "shipping_bill_no"
    t.string "shipping_bill_date"
    t.string "pos"
    t.string "export_type"
    t.string "transportation_mode"
    t.string "vehicle_number"
    t.string "narration"
    t.string "terms_and_conditions"
    t.index ["customer_id"], name: "index_export_invoices_on_customer_id"
    t.index ["user_id"], name: "index_export_invoices_on_user_id"
  end

  create_table "export_purchase_bill_items", force: :cascade do |t|
    t.bigint "export_purchase_bill_id"
    t.bigint "item_id"
    t.integer "quantity"
    t.float "net_amount"
    t.float "tax_rate"
    t.float "tax_amt"
    t.float "total_amt"
    t.string "item_description"
    t.integer "unit_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["export_purchase_bill_id"], name: "index_export_purchase_bill_items_on_export_purchase_bill_id"
    t.index ["item_id"], name: "index_export_purchase_bill_items_on_item_id"
  end

  create_table "export_purchase_bills", force: :cascade do |t|
    t.string "purchase_no"
    t.date "date"
    t.bigint "customer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["customer_id"], name: "index_export_purchase_bills_on_customer_id"
    t.index ["user_id"], name: "index_export_purchase_bills_on_user_id"
  end

  create_table "general_settings", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "contact_no"
    t.string "email"
    t.string "business_description"
    t.string "gst_no"
    t.string "pan"
    t.string "name_of_service"
    t.string "service_acc_code"
    t.string "rate_of_tax"
    t.string "address"
    t.string "state_name"
    t.string "state_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "hsn_summary_for_purchase_bills", force: :cascade do |t|
    t.string "hsn_no"
    t.string "description"
    t.string "uqc"
    t.string "total_value"
    t.string "taxable_value"
    t.string "igst"
    t.string "cgst"
    t.string "sgst"
    t.string "cess"
    t.string "total_quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hsn_summary_for_sale_bills", force: :cascade do |t|
    t.string "hsn_no"
    t.string "description"
    t.string "uqc"
    t.string "total_value"
    t.string "taxable_value"
    t.string "igst"
    t.string "cgst"
    t.string "sgst"
    t.string "cess"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "invoice_id"
    t.string "total_quantity"
    t.bigint "user_id"
    t.bigint "issue_note_id"
    t.index ["invoice_id"], name: "index_hsn_summary_for_sale_bills_on_invoice_id"
    t.index ["issue_note_id"], name: "index_hsn_summary_for_sale_bills_on_issue_note_id"
    t.index ["user_id"], name: "index_hsn_summary_for_sale_bills_on_user_id"
  end

  create_table "invoice_items", force: :cascade do |t|
    t.integer "invoice_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "item_id"
    t.string "number"
    t.string "quantity"
    t.string "net_amt"
    t.decimal "tax_rate", precision: 10, scale: 2
    t.decimal "tax_amt", precision: 10, scale: 2
    t.string "total_amt"
    t.string "item_descritption"
    t.string "unit_price"
  end

  create_table "invoices", force: :cascade do |t|
    t.string "invoice_no"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "customer_id"
    t.integer "item_id"
    t.string "shipping_address"
    t.string "gstr_holder"
    t.bigint "user_id"
    t.string "rcm"
    t.string "invoice_value"
    t.string "ebay_bill_no"
    t.string "total_invoice_value"
    t.string "cess"
    t.string "tax_rate"
    t.string "pos"
    t.string "narration"
    t.string "terms_and_conditions"
    t.string "transportation_mode"
    t.string "vehicle_number"
    t.index ["user_id"], name: "index_invoices_on_user_id"
  end

  create_table "issue_note_items", force: :cascade do |t|
    t.bigint "issue_note_id"
    t.bigint "item_id"
    t.string "unit_price"
    t.string "quantity"
    t.string "rate"
    t.string "net_amt"
    t.string "sgst"
    t.string "cgst"
    t.string "tax_rate"
    t.string "tax_amt"
    t.string "total_amt"
    t.string "qty"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["issue_note_id"], name: "index_issue_note_items_on_issue_note_id"
    t.index ["item_id"], name: "index_issue_note_items_on_item_id"
  end

  create_table "issue_notes", force: :cascade do |t|
    t.bigint "customer_id"
    t.date "date_of_original_invoice"
    t.string "invoice_no"
    t.string "gstin_no"
    t.string "e_way_bill_no"
    t.date "date_of_issue_note"
    t.string "issue_note_no"
    t.string "pre_gst"
    t.string "place_of_supply"
    t.string "reason_for_issuing_note"
    t.string "register_type"
    t.string "note_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.string "invoice_value"
    t.string "cess"
    t.string "total_invoice_value"
    t.string "document_type"
    t.string "tax_rate"
    t.string "ur_types"
    t.index ["customer_id"], name: "index_issue_notes_on_customer_id"
    t.index ["user_id"], name: "index_issue_notes_on_user_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "dogns"
    t.string "item_hsn_no"
    t.string "uom"
    t.string "qty"
    t.string "rate"
    t.string "taxable_value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "customer_id"
    t.decimal "cgst"
    t.decimal "sgst"
    t.decimal "igst"
    t.bigint "unit_of_measure_id"
    t.bigint "user_id"
    t.string "item_code"
    t.index ["unit_of_measure_id"], name: "index_items_on_unit_of_measure_id"
    t.index ["user_id"], name: "index_items_on_user_id"
  end

  create_table "job_work_inward_items", force: :cascade do |t|
    t.string "taxable_value"
    t.string "unit_price"
    t.string "quantity"
    t.string "types_of_goods"
    t.string "integrated_tax_rate"
    t.string "string"
    t.string "central_tax_rate"
    t.string "state_tax_rate"
    t.string "cess"
    t.string "item_id"
    t.string "integer"
    t.integer "job_work_inward_id"
    t.string "total_amt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "job_work_inwards", force: :cascade do |t|
    t.string "gstin_of_job_worker"
    t.string "state"
    t.string "challan_no"
    t.date "challan_date"
    t.integer "user_id"
    t.string "e_way_bill_no"
    t.string "transportation_mode"
    t.string "vehicle_no"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "nature_of_transaction"
    t.string "nature_of_processing"
  end

  create_table "job_work_items", force: :cascade do |t|
    t.string "taxable_value"
    t.string "unit_price"
    t.string "quantity"
    t.string "types_of_goods"
    t.string "integrated_tax_rate"
    t.string "central_tax_rate"
    t.string "state_tax_rate"
    t.string "cess"
    t.bigint "item_id"
    t.bigint "job_work_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "total_amt"
    t.index ["item_id"], name: "index_job_work_items_on_item_id"
    t.index ["job_work_id"], name: "index_job_work_items_on_job_work_id"
  end

  create_table "job_works", force: :cascade do |t|
    t.string "gstin_of_job_worker"
    t.string "state"
    t.string "challan_no"
    t.date "challan_date"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "e_way_bill_no"
    t.string "transportation_mode"
    t.string "vehicle_no"
    t.string "total_amt"
    t.string "nature_of_processing"
    t.bigint "customer_id"
    t.index ["customer_id"], name: "index_job_works_on_customer_id"
    t.index ["user_id"], name: "index_job_works_on_user_id"
  end

  create_table "nillrate_exempt_bill_items", force: :cascade do |t|
    t.bigint "item_id"
    t.bigint "nillrate_exempt_bill_id"
    t.integer "quantity"
    t.float "net_amount"
    t.float "tax_rate"
    t.float "tax_amt"
    t.float "total_amt"
    t.string "item_description"
    t.integer "unit_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_nillrate_exempt_bill_items_on_item_id"
    t.index ["nillrate_exempt_bill_id"], name: "index_nillrate_exempt_bill_items_on_nillrate_exempt_bill_id"
  end

  create_table "nillrate_exempt_bills", force: :cascade do |t|
    t.string "purchase_no"
    t.date "date"
    t.bigint "customer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["customer_id"], name: "index_nillrate_exempt_bills_on_customer_id"
    t.index ["user_id"], name: "index_nillrate_exempt_bills_on_user_id"
  end

  create_table "other_challan_items", force: :cascade do |t|
    t.string "taxable_value"
    t.string "unit_price"
    t.string "quantity"
    t.string "integrated_tax_rate"
    t.string "string"
    t.string "central_tax_rate"
    t.string "state_tax_rate"
    t.string "cess"
    t.string "item_id"
    t.string "integer"
    t.string "job_work_inward_id"
    t.string "total_amt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "other_challan_id"
  end

  create_table "other_challans", force: :cascade do |t|
    t.string "state"
    t.string "string"
    t.string "challan_no"
    t.date "challan_date"
    t.integer "user_id"
    t.string "to_whom"
    t.string "nature_of_processing"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "parties", force: :cascade do |t|
    t.string "party_name"
    t.string "party_gstin_no"
    t.string "party_arn_no"
    t.string "party_address"
    t.string "place_of_supply"
    t.string "commodity_name"
    t.string "tarrif_no"
    t.string "hsn_no"
    t.string "rate_of_tax"
    t.string "name_service"
    t.string "service_acc_code"
    t.string "party_pan_no"
    t.string "state_name"
    t.string "state_code"
    t.string "ca_name"
    t.string "ca_contact"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.string "party_no"
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.bigint "charted_accountant_id"
    t.string "composite"
    t.string "regular"
    t.boolean "party_status", default: false
    t.string "contact_no"
    t.string "alternate_contact_no"
    t.date "joining_date"
    t.date "due_date"
    t.string "party_type"
    t.index ["charted_accountant_id"], name: "index_parties_on_charted_accountant_id"
  end

  create_table "purchase_bill_items", force: :cascade do |t|
    t.bigint "item_id"
    t.bigint "purchase_bill_id"
    t.integer "quantity"
    t.float "net_amount"
    t.float "tax_rate"
    t.float "tax_amt"
    t.float "total_amt"
    t.string "item_description"
    t.integer "unit_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_purchase_bill_items_on_item_id"
    t.index ["purchase_bill_id"], name: "index_purchase_bill_items_on_purchase_bill_id"
  end

  create_table "purchase_bills", force: :cascade do |t|
    t.string "purchase_no"
    t.date "date"
    t.bigint "customer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.string "type"
    t.string "pos"
    t.string "bill_type"
    t.string "invoice_value"
    t.string "tax_rate"
    t.string "total_invoice_value"
    t.string "transportation_mode"
    t.string "vehicle_number"
    t.string "rcm"
    t.string "narration"
    t.string "terms_and_conditions"
    t.index ["customer_id"], name: "index_purchase_bills_on_customer_id"
    t.index ["user_id"], name: "index_purchase_bills_on_user_id"
  end

  create_table "receipt_voucher_items", force: :cascade do |t|
    t.string "details"
    t.string "amount"
    t.bigint "receipt_voucher_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["receipt_voucher_id"], name: "index_receipt_voucher_items_on_receipt_voucher_id"
  end

  create_table "receipt_vouchers", force: :cascade do |t|
    t.string "debit_acc_no"
    t.string "to_whom"
    t.string "against"
    t.string "cash_or_check"
    t.string "total_amount"
    t.string "voucher_no"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "customer_id"
    t.string "check_no"
    t.index ["customer_id"], name: "index_receipt_vouchers_on_customer_id"
    t.index ["user_id"], name: "index_receipt_vouchers_on_user_id"
  end

  create_table "refund_voucher_items", force: :cascade do |t|
    t.string "details"
    t.string "amount"
    t.string "total"
    t.bigint "refund_voucher_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["refund_voucher_id"], name: "index_refund_voucher_items_on_refund_voucher_id"
  end

  create_table "refund_vouchers", force: :cascade do |t|
    t.string "debit_acc_no"
    t.string "to_whom"
    t.string "against"
    t.string "cash_or_check"
    t.string "total_amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "date"
    t.string "voucher_no"
    t.bigint "user_id"
    t.bigint "customer_id"
    t.string "check_n"
    t.index ["customer_id"], name: "index_refund_vouchers_on_customer_id"
    t.index ["user_id"], name: "index_refund_vouchers_on_user_id"
  end

  create_table "reports", force: :cascade do |t|
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "gstr_type"
  end

  create_table "settings", force: :cascade do |t|
    t.string "p_series"
    t.string "s_series"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ExpPurchase"
    t.string "Exempt"
    t.string "export_sale_series"
    t.string "nillrated_sale_series"
    t.string "cd_series"
    t.string "rv_series"
    t.string "jw_series"
  end

  create_table "unit_of_measures", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_unit_of_measures_on_user_id"
  end

  create_table "user_charted_accountants", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "charted_accountant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["charted_accountant_id"], name: "index_user_charted_accountants_on_charted_accountant_id"
    t.index ["user_id"], name: "index_user_charted_accountants_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "general_setting_id"
    t.string "role"
    t.bigint "charted_accountant_id"
    t.bigint "party_id"
    t.string "first_name"
    t.string "username"
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.bigint "setting_id"
    t.index ["charted_accountant_id"], name: "index_users_on_charted_accountant_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["general_setting_id"], name: "index_users_on_general_setting_id"
    t.index ["party_id"], name: "index_users_on_party_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["setting_id"], name: "index_users_on_setting_id"
  end

  add_foreign_key "b2b_composite_items", "b2b_composites"
  add_foreign_key "b2b_composite_items", "items"
  add_foreign_key "b2b_composites", "customers"
  add_foreign_key "b2b_composites", "users"
  add_foreign_key "composite_cd_note_items", "composite_cd_notes"
  add_foreign_key "composite_cd_note_items", "items"
  add_foreign_key "composite_cd_notes", "customers"
  add_foreign_key "composite_cd_notes", "users"
  add_foreign_key "credit_debit_note_items", "credit_debit_notes"
  add_foreign_key "credit_debit_note_items", "items"
  add_foreign_key "credit_debit_notes", "customers"
  add_foreign_key "credit_debit_notes", "users"
  add_foreign_key "customers", "users"
  add_foreign_key "exempt_invoice_items", "exempt_invoices"
  add_foreign_key "exempt_invoice_items", "items"
  add_foreign_key "exempt_invoices", "customers"
  add_foreign_key "exempt_invoices", "users"
  add_foreign_key "export_invoice_items", "export_invoices"
  add_foreign_key "export_invoice_items", "items"
  add_foreign_key "export_invoices", "customers"
  add_foreign_key "export_invoices", "users"
  add_foreign_key "export_purchase_bill_items", "export_purchase_bills"
  add_foreign_key "export_purchase_bill_items", "items"
  add_foreign_key "export_purchase_bills", "customers"
  add_foreign_key "export_purchase_bills", "users"
  add_foreign_key "hsn_summary_for_sale_bills", "invoices"
  add_foreign_key "hsn_summary_for_sale_bills", "issue_notes"
  add_foreign_key "hsn_summary_for_sale_bills", "users"
  add_foreign_key "invoices", "users"
  add_foreign_key "issue_note_items", "issue_notes"
  add_foreign_key "issue_note_items", "items"
  add_foreign_key "issue_notes", "customers"
  add_foreign_key "issue_notes", "users"
  add_foreign_key "items", "unit_of_measures"
  add_foreign_key "items", "users"
  add_foreign_key "job_work_items", "items"
  add_foreign_key "job_work_items", "job_works"
  add_foreign_key "job_works", "customers"
  add_foreign_key "job_works", "users"
  add_foreign_key "nillrate_exempt_bill_items", "items"
  add_foreign_key "nillrate_exempt_bill_items", "nillrate_exempt_bills"
  add_foreign_key "nillrate_exempt_bills", "customers"
  add_foreign_key "nillrate_exempt_bills", "users"
  add_foreign_key "parties", "charted_accountants"
  add_foreign_key "purchase_bill_items", "items"
  add_foreign_key "purchase_bill_items", "purchase_bills"
  add_foreign_key "purchase_bills", "customers"
  add_foreign_key "purchase_bills", "users"
  add_foreign_key "receipt_voucher_items", "receipt_vouchers"
  add_foreign_key "receipt_vouchers", "customers"
  add_foreign_key "receipt_vouchers", "users"
  add_foreign_key "refund_voucher_items", "refund_vouchers"
  add_foreign_key "refund_vouchers", "customers"
  add_foreign_key "refund_vouchers", "users"
  add_foreign_key "unit_of_measures", "users"
  add_foreign_key "user_charted_accountants", "charted_accountants"
  add_foreign_key "user_charted_accountants", "users"
  add_foreign_key "users", "charted_accountants"
  add_foreign_key "users", "general_settings"
  add_foreign_key "users", "parties"
  add_foreign_key "users", "settings"
end
