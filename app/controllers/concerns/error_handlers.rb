module ErrorHandlers
  ## Concernディレクトリ内では必ずextendする
  extend ActiveSupport::Concern

  included do
    # 例外が発生した場合、rescue500メソッドに処理を任せる
    ## ただし、RailsガイドではStandardErrorをcatchするのを避けるように明示してある
    ## https://railsguides.jp/action_controller_overview.html
    rescue_from StandardError, with: :rescue500

    # 権限不足・アクセス制限
    rescue_from ApplicationController::Forbidden, with: :rescue403
    rescue_from ApplicationController::IpAddressRejected, with: :rescue403

    # レコードに該当のデータが存在しない場合、404エラーを表示する
    rescue_from ActiveRecord::RecordNotFound, with: :rescue404

    # クライアントからのリクエストが正しくない場合、400エラーを表示する
    rescue_from ActionController::ParameterMissing, with: :rescue400
  end

  private
  def rescue400(e)
    render 'errors/bad_request', status: 400
  end

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