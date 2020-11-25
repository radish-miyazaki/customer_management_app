Rails.application.configure do
  # 一時的にStrongParameterを不可にする
  config.action_controller.permit_all_parameters = true
end