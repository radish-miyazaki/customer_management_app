class StaffMember < ApplicationRecord

  # 与えられた文字列をハッシュ化し返す
  # nilの場合はそのままnilを返す
  def password=(raw_password)
    if raw_password.kind_of?(String)
      self.hashed_password = BCrypt::Password.create(raw_password)
    elsif raw_password.nil?
      self.hashed_password = nil
    end
  end
end
