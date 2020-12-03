class Phone < ApplicationRecord
  include StringNormalizer

  belongs_to :customer, optional: true
  belongs_to :address, optional: true

  # 正規化
  before_validation do
    self.number = normalize_as_phone_number(number)
    self.number_for_index = number.gsub(/\D/, "") if number # 数字以外の文字を全て除去
  end

  # DBにはじめて保存される前に実行
  before_create do
    self.customer = address.customer if address
  end

  validates :number, presence: true,
    format: { with: /\A\+?\d+(-\d+)*\z/, allow_blank: true }
end
