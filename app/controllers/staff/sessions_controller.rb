class Staff::SessionsController < Staff::Base
  skip_before_action :authorize

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
    @form = Staff::LoginForm.new(login_form_params)

    # email属性の値が存在する場合
    if @form.email.present?
      
      # 同じemailを探す
      staff_member =
        StaffMember.find_by("LOWER(email) = ?", @form.email.downcase)
    end

    # 同じemailが存在した場合の処理
    if Staff::Authenticator.new(staff_member).authenticator(@form.password)
      # 無効フラグがtrueの場合
      if staff_member.suspected?
        staff_member.events.create!(type: 'rejected')
        flash.now.alert = "アカウントが停止されています。"
        render action: "new"
      else
        session[:staff_member_id] = staff_member.id
        session[:last_access_time] = Time.current # セッションタイムアウト用に現在の時刻をセッションオブジェクトに記録
        staff_member.events.create!(type: 'logged_in')
        flash.notice = "ログインしました。"
        redirect_to :staff_root
      end
    else
      flash.now.alert = "メールアドレスまたはパスワードが正しくありません。"
      render action: "new"
    end
  end

  def destroy
    if current_staff_member
      current_staff_member.events.create!(type: 'logged_out')
    end
    session.delete(:staff_member_id)
    flash.notice = "ログアウトしました。"
    redirect_to :staff_root
  end

  private
    def login_form_params
      params.require(:staff_login_form).permit(:email, :password)
    end
  
end
