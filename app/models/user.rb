class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  scope :shod, ->(id) { where(id: id).take }
  has_attached_file :image
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  scope :role_wise_users, ->(role) { where(role: role) }
  belongs_to :general_setting
  belongs_to :charted_accountant
  belongs_to :party
  belongs_to :setting
  has_many :items, dependent: :destroy
  has_many :unit_of_measures, dependent: :destroy
  has_many :customers, dependent: :destroy
  has_many :invoices, dependent: :destroy
  has_many :export_invoices, dependent: :destroy
  has_many :exempt_invoices, dependent: :destroy
  has_many :credit_debit_notes, dependent: :destroy
  has_many :issue_notes, dependent: :destroy
  has_many :purchase_bills, dependent: :destroy
  has_many :export_purchase_bills, dependent: :destroy
  has_many :nillrate_exempt_bills, dependent: :destroy
  has_many :refund_vouchers, dependent: :destroy
  has_many :receipt_vouchers, dependent: :destroy
  has_many :job_works, dependent: :destroy
  has_many :job_work_inwards, dependent: :destroy
  has_many :other_challans, dependent: :destroy
  has_many :hsn_summary_for_sale_bills, dependent: :destroy


  def create_general_setting
    role = 'Party'
    role = 'SuperAdmin' if id == 1
    gs = GeneralSetting.create(name_of_service: 'GST ')
    update(general_setting_id: gs.id, role: role)
  end

  # def create_user_charted_accountant(ca_no, email)
  #   employee_number.each do |emp_no|
  #     UserChartedAccountant.create(email: email, ca_no: ca_no)
  #   end
  # end

    def self.current
    Thread.current[:user]
  end

  # setter for current user
  def self.current=(user)
    Thread.current[:user] = user
  end
end
