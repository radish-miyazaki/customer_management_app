require "rails_helper"

describe Admin::Authenticator do
  describe "#authenticate" do
    example "正しいパスワードならtrueを返す" do
      a = build(:administrator)
      expect(Admin::Authenticator.new(a).authenticator("password")).to be_truthy  
    end

    example "間違ったパスワードならfalseを返す" do
      a = build(:administrator)
      expect(Admin::Authenticator.new(a).authenticator("wrongpassword")).to be_falsey
    end

    example "パスワードがnil（未設定）ならfalseを返す" do
      a = build(:administrator, password: nil)
      expect(Admin::Authenticator.new(a).authenticator(nil)).to be_falsey
    end

    example "無効フラグ（suspended）が立ってる（true）ならばfalseを返す" do
      a = build(:administrator, suspended: true)
      expect(Admin::Authenticator.new(a).authenticator("password")).to be_falsey
    end
  end
end
