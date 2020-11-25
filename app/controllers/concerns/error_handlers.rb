module ErrorHandles
  extend ActiveSupport::Concern
  included do
    # 例外が発生した場合、rescue500メソッドに処理を任せる
    ## ただし、RailsガイドではStandardErrorをcatchするのを避けるように明示してある
    ## https://railsguides.jp/action_controller_overview.html
    rescue_from StandardError, with: :rescue500

    # 権限不足・アクセス制限
    rescue_from ActionController::Forbidden, with: :rescue403
    rescue_from ActionController::IpAddressRejected, with: :rescue403

    # レコードに該当のデータが存在しない場合、404エラーを表示する
    rescue_from ActiveRecord::RecordNotFound, with: :rescue404
  end

  private
    def rescue403(e)
      # @exception = e
      render template: "errors/forbidden", status: 403
    end

    def rescue404(e)
      render "errors/not_found", status: 404
    end

    def rescue500(e)
      render "errors/internal_server_error", status: 500
    end
end