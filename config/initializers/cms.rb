# ルーティングが適用される条件を記載するファイル
Rails.application.configure do
  config.cms = {
    staff: { host: "cms.example.com", path: "" },
    admin: { host: "cms.example.com", path: "admin" },
    customer: { host: "example.com", path: "mypage"}
  }
end