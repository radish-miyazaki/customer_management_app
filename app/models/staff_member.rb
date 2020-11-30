class StaffMember < ApplicationRecord

  has_many :events, class_name: 'StaffEvent', dependent: :destroy

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
