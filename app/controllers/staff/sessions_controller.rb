class Staff::SessionsController < Staff::Base
  def new
    # ログイン状態かどうか
    if current_staff_member
      redirect_to :staff_root # メイン画面にリダイレクト
    else
      @form = Staff::LoginForm.new
      render action: "new"
    end
  end

  def create
    # インスタンス変数の各属性の値を代入する
    @form = Staff::LoginForm.new(params[:staff_login_form])

    # email属性の値が存在する場合
    if @form.email.present?
      
      # 同じemailを探す
      staff_member =
        StaffMember.find_by("LOWER(email) = ?", @form.email.downcase)
    end

    # 同じemailが存在した場合の処理
    if Staff::Authenticator.new(staff_member).authenticator(@form.password)
      session[:staff_member_id] = staff_member.id # 仮実装（バリデーションなし）
      redirect_to :staff_root 
    else
      render action: "new"
    end
  end

  def destroy
    session.delete(:staff_member_id)
    redirect_to :staff_root
  end
  
end
