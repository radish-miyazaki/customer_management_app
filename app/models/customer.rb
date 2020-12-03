class Customer < ApplicationRecord

  include PersonalNameHolder
  include EmailHolder
  include PasswordHolder

  # モデル間に一対一の関連づけをおこなう
  has_one :home_address, dependent: :destroy, autosave: true
  has_one :work_address, dependent: :destroy, autosave: true

  # CustomerモデルとPhoneモデルを結びつける
  has_many :phones, dependent: :destroy # 顧客の持つ全ての番号
  has_many :personal_phones, -> { where(address_id: nil).order(:id) },
    class_name: "Phone", autosave: true # 顧客個人の番号

  # Validation
  validates :gender, inclusion: { in: %w(male female), allow_blank: true}
  validates :birthday, date: {
    after: Date.new(1900, 1, 1),
    before: ->(obj) { Date.today },
    allow_blank: true
  }
end
