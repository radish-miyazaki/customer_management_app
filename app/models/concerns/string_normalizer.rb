require 'nkf'

module StringNormalizer
  extend ActiveSupport::Concern

  # 文字列の前後の空白を除去（strip）し、正規化
  def normalize_as_name(text)
    NKF.nkf("-W -w -Z1", text).strip if text
  end

  # ひらがなをカタカナに変換し、正規化
  def normalize_as_furigan(text)
    NKF.nkf("-W -w -Z1 --katakana", text).strip if text
  end

  # メールアドレスの正規化
  def normalize_as_email(text)
    NKF.nkf("-W -w -Z1", text).strip if text
  end

  # 郵便番号の正規化
  def normalize_as_postal_code(text)
    NKF.nkf("-W -w -Z1", text).strip.gsub(/-/, "") if text
  end

  # 電話番号の正規化
  def normalize_as_phone_number(text)
    NKF.nkf("-W -w -Z1", text).strip if text
  end
end
