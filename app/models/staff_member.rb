class StaffMember < ApplicationRecord

  include EmailHolder # メールアドレスの正規化&バリデーションファイル
  include PersonalNameHolder # 名前の正規化＆バリデーションファイル
  include PasswordHolder # パスワード関連のファイル

  has_many :events, class_name: "StaffEvent", dependent: :destroy

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

  # システムへアクセスできるかどうかを調べる
  def active?
    !suspected &&   # 無効フラグがtrueではないか
    start_date <= Date.today &&  # 入社日が今日より後ではないか
    (end_date.nil? || end_date > Date.today) # 終了日がnil、または今日より後であるか
  end
end
