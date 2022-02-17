require 'rails_helper'

RSpec.describe "GET #index", type: :request do
  let(:user) {FactoryBot.create(:user)}
  describe "#index" do
    context "ログインしていない場合" do
      it "ログインページへリダイレクト" do
        get posts_path(created: 20211208)
        expect(flash).to be_present
        expect(response).to redirect_to login_url
      end
    end
  end
end
