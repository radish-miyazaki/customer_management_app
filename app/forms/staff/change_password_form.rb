class Staff::ChangePasswordForm
  include ActiveModel::Model

  attr_accessor :object, # StaffMemberオブジェクトが入る属性
                :current_password,
                :new_password,
                :new_password_confirmation
  validates :new_password, presence: true, confirmation: true

  validate do
    unless Staff::Authenticator.new(object).authenticator(current_password)
      errors.add(:current_password, :wrong)
    end
  end

  def save
    if valid?
      object.password = new_password
      object.save!
    end
  end
end