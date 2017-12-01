class Invoice < ApplicationRecord
	belongs_to :customer 
  has_many :invoice_items, inverse_of: :invoice
  accepts_nested_attributes_for :invoice_items, reject_if: :all_blank, allow_destroy: true
  scope :shod, ->(id) { where(id: id).take }

  def self.set_invoice_no
    date = Date.today.strftime('%d')
    if Invoice.first.nil?
      'S' + date.to_s + '1'
    else
      last_id = Invoice.last.id.next
      'S' + date.to_s + last_id.to_s
    end
  end

    def field_enum
    if invoice_items.try(:model).present?
      invoice_items.model_attributes
    else
      all_attributes
    end
  end

  private
  
  def all_attributes
    ::MODELS.collect{|k,h| h["attributes"]}.flatten.uniq.sort
end

end

