class StaffMember < ApplicationRecord

  include StringNormalizer

  has_many :events, class_name: "StaffEvent", dependent: :destroy

  # 正規化
  before_validation do
    self.family_name = normalize_as_name(family_name)
    self.given_name = normalize_as_name(given_name)
    self.family_name_kana = normalize_as_furigan(family_name_kana)
    self.given_name_kana = normalize_as_furigan(given_name_kana)
    self.email = normalize_as_email(email)
  end

  KATAKANA_REGEXP = /\A[\p{katakana}\u{30fc}]+\z/

  # 氏名・フリガナのバリエーション
  validates :family_name, :given_name, presence: true
  validates :family_name_kana, :given_name_kana, presence: true,
            format: { with: KATAKANA_REGEXP, allow_nlank: true}

  # 入社日・退職日のバリデーション
  validates :start_date, presence: true, date: {
    after_or_equal_to: Date.new(2000, 1, 1), # 2000年1月1日以降
    before: ->(obj) { 1.year.from_now.to_date }, # 今日の日付より1年後まで許容
    allow_blank: true # 空欄を許可する
  }
  validates :end_date, date: {
    after: :start_date, # 入社日より後
    before: ->(obj) { 1.year.from_now.to_date },
    allow_blank: true
  }

  # メールアドレスのバリデーション(gem valid_email2を用いる)
  validates :email, presence: true, "valid_email_2/email": true,
    uniqueness: { case_sensitive: false }

  # 与えられた文字列をハッシュ化し返す
  # nilの場合はそのままnilを返す
  def password=(raw_password)
    if raw_password.kind_of?(String)
      self.hashed_password = BCrypt::Password.create(raw_password)
    elsif raw_password.nil?
      self.hashed_password = nil
    end
  end

  # システムへアクセスできるかどうかを調べる
  def active?
    !suspected &&   # 無効フラグがtrueではないか
    start_date <= Date.today &&  # 入社日が今日より後ではないか
    (end_date.nil? || end_date > Date.today) # 終了日がnil、または今日より後であるか
  end
end
