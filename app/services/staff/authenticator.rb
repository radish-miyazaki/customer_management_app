class Staff::Authenticator
  def initialize(staff_member)
    @staff_member = staff_member
  end

  # 複数の条件が全て正しい場合のみtrueを返す
  def authenticator(raw_password)
    @staff_member &&  # @staff_memberがnilではない
      # !@staff_member.suspected? &&  # 有効かどうか
      @staff_member.hashed_password && # パスワードが設定されているか
      @staff_member.start_date <= Date.today && # 開始日が今日以前か
      (@staff_member.end_date.nil? || @staff_member.end_date > Date.today) && # 終了日が空欄、または今日以前か
      BCrypt::Password.new(@staff_member.hashed_password) == raw_password # パスワードが正しいか
  end
end