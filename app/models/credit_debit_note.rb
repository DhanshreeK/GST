class CreditDebitNote < ApplicationRecord
  belongs_to :customer
  belongs_to :user
  has_many :credit_debit_note_items, inverse_of: :credit_debit_note
  accepts_nested_attributes_for :credit_debit_note_items, reject_if: :all_blank, allow_destroy: true
  scope :shod, ->(id) { where(id: id).take }
  after_create :add_hsn_summary

   #def self.set_credit_debit_note_no
    #date = Date.today.strftime('%d')
    #if CreditDebitNote.first.nil?
     # Setting.first.cd_series + date.to_s + '1'
    #else
      #last_id = CreditDebitNote.last.id.next
      #Setting.first.cd_series + date.to_s + last_id.to_s
    #end
  #end

   def add_hsn_summary
    self.credit_debit_note_items.each do |s|
   hsn = HsnSummaryForPurchaseBill.create!(hsn_no: s.item.item_hsn_no,description: s.item.dogns, uqc: s.item.unit_of_measure.name, total_value: s.total_amt, taxable_value: s.net_amt, cgst: s.item.cgst, igst: s.item.igst, sgst: s.item.sgst, total_quantity: s.quantity)
  end
  end

end