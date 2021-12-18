require 'rails_helper'

RSpec.describe "GET #index", type: :request do
  it "ログインしていないユーザーはindexアクションにアクセス不可能" do
    get posts_path
    expect(flash).to be_present
    expect(response).to redirect_to login_url
  end

  

  

end
