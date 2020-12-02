Rails.application.routes.draw do
  config = Rails.application.config.cms

  # config/cms.rbファイル内で指定したホスト名で
  # アクセスされたときのみ職員トップページが表示される
  constraints host: config[:staff][:host] do
    namespace :staff, path: config[:staff][:path] do
      root 'top#index'
      get "login" => "sessions#new", as: :login
      resource :session, only: [ :create, :destroy ]

      # 職員が自分自身を管理するためのルーティング
      resource :account, except: [ :new, :create, :destroy ] # 職員自身は自分のアカウントを削除・更新・作成できない
      resource :password, only: [ :show, :edit, :update ] # 職員自身がパスワードを変更する
      
      # 職員が顧客情報を管理するためのルーティング
      resouces :customers
    end
  end

  constraints host: config[:admin][:host] do
    namespace :admin, path: config[:admin][:path] do
      root 'top#index'
      get "login" => "sessions#new", as: :login
      resource :session, only: [ :create, :destroy ]

      # 管理者が職員(staff)を管理するためのルーティング
      resources :staff_members do
        resources :staff_events, only: [:index] # 特定の職員の記録を見る
      end
      resources :staff_events, only: [:index] # すべての職員の記録を見る
    end
  end

  constraints host: config[:customer][:host] do
    namespace :customer, path: config[:customer][:path] do
      root 'top#index'
    end
  end
end
