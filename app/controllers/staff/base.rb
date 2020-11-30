## Staffモデル全体に共通するメソッドを定義するクラス
class Staff::Base < ApplicationController
  before_action :authorize
  before_action :check_account
  before_action :check_timeout

  private

    def current_staff_member
      if session[:staff_member_id]
        # 遅延初期化（最初の1回のみ呼びだされる）
        @current_staff_member ||= 
          StaffMember.find_by(id: session[:staff_member_id])
      end
    end
    
    def authorize
      unless current_staff_member
        flash.alert = "職員としてログインしてください。"
        redirect_to :staff_login
      end
    end

    def check_account
      if current_staff_member && !current_staff_member.active?
        session.delete(:staff_member_id)
        flash.alert = "アカウントが無効になりました。"
        redirect_to :staff_root
      end
    end

    TIMEOUT = 60.minutes # セッションタイムアウトのリミット

    def check_timeout
      if current_staff_member
        # 最終アクセス時刻が現在から60分以内の場合
        if session[:last_access_time] >= TIMEOUT.ago
          # 最終アクセス時刻を更新する
          session[:last_access_time] = Time.current
        else
          # セッションを削除し、ログイン画面にリダイレクトする
          session.delete(:staff_member_id)
          flash.alert = "セッションがタイムアウトしました。"
          redirect_to :staff_login
        end
      end
    end

    # helper_method(app/helpers/application_helper)に登録する
    helper_method :current_staff_member
end