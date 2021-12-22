require 'rails_helper'

RSpec.describe "Schedules_controller", type: :request do
  let(:user) {FactoryBot.create(:user)}
  let(:other) {FactoryBot.create(:user)}
  describe "#show" do
    context "ログインしていない場合" do
      it "ログインページへリダイレクト" do
        get schedule_path(user)
        expect(flash).to be_present
        expect(response).to redirect_to login_url
      end
    end

    context "ログインしている場合" do
      context "他人のスケジュールページへのリクエスト" do
        it "プロフィールページへリダイレクト" do
          sign_in(other)
          get schedule_path(user)
          expect(flash).to be_present
          expect(response).to redirect_to root_url
        end
      end

      context "自分のスケジュールページへのリクエスト" do
        it "スケジュールページを表示" do
          sign_in(user)
          get schedule_path(user)
          expect(response).to have_http_status "200"
          expect(response).to render_template("show")
        end
      end
    end
  end

  describe "#new" do
    context "ログインしていない場合" do
      it "ログインページへリダイレクト" do
        get new_schedule_path
        expect(flash).to be_present
        expect(response).to redirect_to login_url
      end
    end

    context "ログインしている場合" do
      it "スケジュール作成ページを表示" do
        sign_in(user)
        get new_schedule_path
        expect(response).to have_http_status "200"
        expect(response).to render_template("new")
      end
    end
  end

  
end
