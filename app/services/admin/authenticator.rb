class Admin::Authenticator
  def initialize(administrator)
    @administrator = administrator
  end

  def authenticator(raw_password)
    @administrator &&
    !@administrator.suspended? &&
    @administrator.hashed_password &&
    BCrypt::Password.new(@administrator.hashed_password) == raw_password
  end
end
