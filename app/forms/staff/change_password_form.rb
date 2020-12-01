class Staff::ChangePasswordForm
  include ActiveModel::Model

  attr_accessor :object, # StaffMemberオブジェクトが入る属性
                :current_password,
                :new_password,
                :new_password_confirm

  def save
    object.password = new_password
    object.save!
  end
end