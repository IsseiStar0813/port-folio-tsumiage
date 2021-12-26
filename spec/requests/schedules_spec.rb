require 'rails_helper'

RSpec.describe "Schedules_controller", type: :request do
  let(:user) {FactoryBot.create(:user)}
  let(:other) {FactoryBot.create(:user)}
  let(:schedule_brank_task)  {FactoryBot.attributes_for(:schedule, user_id: user.id, task: "")}
  let(:schedule) {FactoryBot.attributes_for(:schedule, user_id: user.id)}
  describe "#show" do
    context "ログインしていない場合" do
      it "ログインページへリダイレクト" do
        get schedule_path(user)
        expect(flash).to be_present
        expect(response).to redirect_to login_url
      end
    end

    context "ログインしている場合" do
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

  describe "#create" do
    context "ログインしていない場合" do
      it "ログインページへリダイレクト" do
        post schedules_path
        expect(flash).to be_present
        expect(response).to redirect_to login_url
      end
    end

    context "ログインしている場合" do
      before do
        sign_in(user)
      end

      context "タスク名が空白の場合" do
        it "タスクを作成せず、もう一度作成ページをレンダリング" do
          post schedules_path, params: {schedule: schedule_brank_task }
          expect(response).to render_template "shared/_error_message"
          expect(response).to render_template "new"
        end
      end

      context "正しい情報の場合" do
        it "タスクを作成、スケジュールページへリダイレクト" do      
          post schedules_path, params: {schedule: schedule }
          expect(flash).to be_present
          expect(response).to redirect_to schedule_path(user)
        end
      end
    end
  end

  describe "index" do
    context "ログインしていない場合" do
      it "ログインページへリダイレクト" do
        get schedules_path
        expect(flash).to be_present
        expect(response).to redirect_to login_url
      end
    end

    context "ログインしている場合" do
      before do
        sign_in(user)
      end
      it "params[:created]が存在しない場合" do
        get schedules_path
        expect(response).to redirect_to user
      end
      it "params[:created]が存在する場合" do
        get schedules_path(created: 20211208)
        expect(response).to have_http_status "200"
        expect(response).to render_template("index")
      end
    end
  end

  
end
