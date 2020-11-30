require 'rails_helper'

describe "職員によるアカウント管理" do

  before do
    # 職員がログインフォームに自分のemailとpwを入力して、フォームを送信する
    post staff_session_url,
      params: {
        staff_login_form: {
          email: staff_member.email,
          password: 'password'
        }
      }
  end
  describe "更新" do
    let(:params_hash) { attributes_for(:staff_member) }
    let(:staff_member) { create(:staff_member) }

    example "email属性を変更する" do
      params_hash.merge!(email: "test@example.com")
      patch staff_account_url,
        params: { id: staff_member.id, staff_member: params_hash}
      staff_member.reload
      expect(staff_member.email).to eq('test@example.com')
    end

    example "例外ActionController::ParameterMissingが発生" do
      expect { patch staff_account_url, params: { id: staff_member.id} }.
        to raise_error(ActionController::ParameterMissing)
    end

    example "end_dateの書き換えは不可" do
      params_hash.merge!(end_date: Date.tomorrow)
      expect {
        patch staff_account_url,
          params: { id: staff_member.id, staff_member: params_hash}
      }.not_to change { staff_member.end_date }
    end
  end
end