require 'rails_helper'

RSpec.describe "GET #index", type: :request do

  let(:user) {FactoryBot.create(:user)}

  it "#index" do
    context "ログインしていない場合、ログインページへリダイレクト" do
      get posts_path(created: 20211208)
      expect(flash).to be_present
      expect(response).to redirect_to login_url
    end

    context "ログインしていて,params[:created]が存在しない場合、プロフィールページへリダイレクト" do
      sign_in(user)
      get posts_path
      expect(response).to redirect_to user
    end

    context "ログイン中、かつparams[:created]が存在する場合" do
      sign_in(user)
      get posts_path(created: 20211208)
      expect(response).to have_http_status "200"
    end
   
  end

end
