require 'rails_helper'

RSpec.describe "GET #index", type: :request do
  it "ログインしていないユーザーはindexアクションにアクセス不可能" do
    get posts_path(created: 20211208)
    expect(flash).to be_present
    expect(response).to redirect_to login_url
  end

  it "ログインしていても,params[:created]が存在しないとindexアクションにアクセス不可能"do
    user = FactoryBot.create(:user)
    sign_in(user)
    get posts_path
    expect(response).to redirect_to user
  end

  it "ログインしていて、かつparams[:created]が存在する場合、indexアクションにアクセス可能"do
    user = FactoryBot.create(:user)
    sign_in(user)
    get posts_path(created: 20211208)
    expect(response).to have_http_status "200"
  end

  

end
