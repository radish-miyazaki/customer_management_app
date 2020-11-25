require "rails_helper"

describe Staff::Authenticator do
  describe "#authenticator" do
    example "正しいパスワードならtrueを返す" do
      m = build(:staff_member)
      expect(Staff::Authenticator.new(m).authenticator("password")).to be_truthy  
    end

    example "間違ったパスワードならfalseを返す" do
      m = build(:staff_member)
      expect(Staff::Authenticator.new(m).authenticator("wrongpassword")).to be_falsey
    end

    example "パスワードが未設定ならfalseを返す" do
      m = build(:staff_member, password: nil)
      expect(Staff::Authenticator.new(m).authenticator(nil)).to be_falsey
    end
    
    example "開始日がテスト実施時点より後ならばfalseを返す" do
      m = build(:staff_member, start_date: Date.tomorrow)
      expect(Staff::Authenticator.new(m).authenticator("password")).to be_falsey
    end

    example "終了日が開始日より前ならばfalseを返す" do
      m = build(:staff_member, end_date: Date.today)
      expect(Staff::Authenticator.new(m).authenticator("password")).to be_falsey
    end

    # example "無効フラグ(suspected)が立っていたらfalseを返す" do
    example "無効フラグが立っていてもtrueを返す" do
      m = build(:staff_member, suspected: true)
      # expect(Staff::Authenticator.new(m).authenticator("password")).to be_falsey
      expect(Staff::Authenticator.new(m).authenticator("password")).to be_truthy
    end
  end
  
  
end
