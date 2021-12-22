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
    context "ログインしていて,params[:created]が存在しない場合" do
      it "プロフィールページへリダイレクト" do
        sign_in(user)
        get posts_path
        expect(response).to redirect_to user
      end
    end
    context "ログイン中、かつparams[:created]が存在する場合" do
      it "投稿一覧ページ表示" do
        sign_in(user)
        get posts_path(created: 20211208)
        expect(response).to have_http_status "200"
        expect(response).to render_template("index")
      end
    end
  end
end
