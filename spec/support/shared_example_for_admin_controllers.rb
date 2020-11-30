# アクセス制限によるリダイレクトを確認するための共有example
shared_examples 'a protected admin controller' do |controller|
  let(:args) do
  {
    host: Rails.application.config.cms[:admin][:host],
    controller: controller
  }
  end
  
  describe "#index" do
    example "ログインフォームにリダイレクト" do
      get url_for(args.merge(action: :index))
      expect(response).to redirect_to(admin_login_url)
    end
  end

  describe "#show" do
    example "ログインフォームにリダイレクト" do
      get url_for(args.merge(action: :show, id: 1))
      expect(response).to redirect_to(admin_login_url)
    end
  end
end

# 単一リソース用のテスト（管理者では使わないので、削除予定）
shared_examples "a protected singular admin controller" do |controller|
  let(:args) do
    {
      host: Rails.application.config.cms[:admin][:host],
      controller: controller
    }
  end

  describe "#show" do
    example "ログインフォームにリダイレクト" do
      get url_for(args.merge(action: :show))
      expect(response).to redirect_to(admin_login_url)
    end
  end
  
end