class Staff::CustomerForm
  include ActiveModel::Model

  attr_accessor :customer
  # 値がDBに保存されているかどうかを真偽値で返すpersisted?メソッドをcustomer属性に委譲
  # persisted?をオーバーライドすることで、form_withによるpersisted?メソッドの呼び出しに対して
  # HTTPメソッドがPOSTに固定されないようにしている。
  delegate :persisted?, :save,  to: :customer

  def initialize(customer = nil)
    @customer = customer
    @customer ||= Customer.new(gender: "male")
    @customer.build_home_address unless @customer.home_address
    @customer.build_work_address unless @customer.work_address
  end

  # フォームから送信されたデータを受け取る
  def assign_attributes(params = {})
    @params = params

    customer.assign_attributes(customer_params) # フォームで入力された値を顧客の各属性に代入
    customer.home_address.assign_attributes(home_address_params) # 自宅住所
    customer.work_address.assign_attributes(work_address_params) # 勤務先
  end

  # Strong Parameters
  private
  def customer_params
    @params.require(:customer).permit(
      :email, :password, :family_name, :given_name, :family_name_kana, :given_name_kana,
      :birthday, :gender
    )
  end

  def home_address_params
    @params.require(:home_address).permit(
      :postal_code, :prefecture, :city, :address1, :address2
    )
  end

  def work_address_params
    @params.require(:work_address).permit(
      :company_name, :division_name,
      :postal_code, :prefecture, :city, :address1, :address2
    )
  end

end
