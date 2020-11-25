class ApplicationController < ActionController::Base

  class Forbidden < ActionController::ActionControllerError; end
  class IpAddressRejected < ActionController::ActionControllerError; end

  # 本番環境のみ専用のエラーページを出力する
  include ErrorHandlers if Rails.env.production?

end
