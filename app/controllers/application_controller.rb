class ApplicationController < ActionController::Base

  layout :set_layout

  class Forbidden < ActionController::ActionControllerError; end
  class IpAddressRejected < ActionController::ActionControllerError; end

  # 本番環境のみ専用のエラーページを出力する
  include ErrorHandlers if Rails.env.production?

  # ユーザごとにレイアウトを変更する
  private
    def set_layout
      if params[:controller].match(%r{\A(staff|customer|admin)/})
        Regexp.last_match[1]
      else
        "customer"
      end
    end

end
