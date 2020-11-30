require 'rails_helper'

describe '管理者による職員管理' do
  let(:administrator) { create(:administrator) }

  describe '新規登録' do
    let(:params_hash) { attributes_for(:staff_member) }

    example '職員一覧ページにリダイレクト' do
      post admin_staff_members_url, params: { staff_member: params_hash }
      expect(response).to redirect_to(admin_staff_members_url)
    end

    example '例外ActionController::ParameterMissingが発生' do
      expect { post admin_staff_members_url}.                  # paramsを空でpostする
        to raise_error(ActionController::ParameterMissing)
    end
  end

  describe '更新' do
    let(:staff_member) { create(:staff_member) }
    let(:params_hash) { attributes_for(:staff_member) }

    example 'suspectedフラグをtrueにする' do
      params_hash.merge!(suspected: true)
      patch admin_staff_member_url(staff_member), params: { staff_member: params_hash }
      staff_member.reload
      expect(staff_member).to be_suspected
    end

    example 'hashed_passwordの書き換えは不可' do
      params_hash.delete(:password)
      params_hash.merge!(hashed_password: '#')
      expect { 
        patch admin_staff_member_url(staff_member), params: { staff_member: params_hash }
      }.not_to change { staff_member.hashed_password.to_s }
    end
  end
end
