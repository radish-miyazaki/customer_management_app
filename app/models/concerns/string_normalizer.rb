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
end