Rails.application.configure do
  # リモートフォーム（指定されたメソッドでAjaxリクエストが送信される）を使わないようにする
  config.action_view.form_with_generates_remote_forms = false
end