## Staffモデル全体に共通するメソッドを定義するクラス
class Staff::Base < ApplicationController
  private

    def current_staff_member
      if session[:staff_member_id]
        # 遅延初期化（最初の1回のみ呼びだされる）
        @current_staff_member ||= 
          StaffMember.find_by(id: session[:staff_member_id])
      end
    end

    # helper_method(app/helpers/application_helper)に登録する
    helper_method :current_staff_member
end