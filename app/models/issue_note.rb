class IssueNote < ApplicationRecord
  belongs_to :customer
  belongs_to :user
  has_many :issue_note_items, inverse_of: :issue_note, dependent: :destroy
  accepts_nested_attributes_for :issue_note_items, reject_if: :all_blank, allow_destroy: true
  scope :shod, ->(id) { where(id: id).take }
  after_create :add_hsn_summary

  


   def add_hsn_summary
    self.issue_note_items.each do |s|
   hsn = HsnSummaryForSaleBill.create!(hsn_no: s.item.item_hsn_no,description: s.item.dogns, uqc: s.item.unit_of_measure.name, total_value: s.total_amt, issue_note_id: self.id, taxable_value: s.net_amt, cgst: s.item.cgst, igst: s.item.igst, sgst: s.item.sgst, total_quantity: s.quantity)
  end
  end

end
