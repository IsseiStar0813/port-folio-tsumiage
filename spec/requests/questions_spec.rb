require 'rails_helper'

RSpec.describe "Questions_controller", type: :request do
  let(:user) {FactoryBot.create(:user)}
  let(:other) {FactoryBot.create(:user)}
  let(:question_brank_title)  {FactoryBot.attributes_for(:question, user_id: user.id, title: "")}
  let(:question_brank_content)  {FactoryBot.attributes_for(:question, user_id: user.id, content: "")}
  let(:question) {FactoryBot.attributes_for(:question, user_id: user.id)}
  describe "#new" do
    context "ログインしていない場合" do
      it "ログインページへリダイレクト" do
        get new_question_path
        expect(flash).to be_present
        expect(response).to redirect_to login_url
      end
    end

    context "ログインしている場合" do
      it "質問投稿ページを表示" do
        sign_in(user)
        get new_question_path
        expect(response).to have_http_status "200"
        expect(response).to render_template("new")
      end
    end
  end

  describe "#create" do
    context "ログインしていない場合" do
      it "ログインページへリダイレクト" do
        post questions_path
        expect(flash).to be_present
        expect(response).to redirect_to login_url
      end
    end

    context "ログインしている場合" do
      before do
        sign_in(user)
      end

      context "titleが空白の場合" do
        it "質問を作成せず、もう一度質問作成ページをレンダリング" do
          post questions_path, params: {question: question_brank_title }
          expect(response).to render_template "shared/_error_message"
          expect(response).to render_template "new"
        end
      end

      context "contentが空白の場合" do
        it "質問を作成せず、もう一度質問作成ページをレンダリング" do
          post questions_path, params: {question: question_brank_content }
          expect(response).to render_template "shared/_error_message"
          expect(response).to render_template "new"
        end
      end

      context "有効な投稿の場合" do
        it "質問を作成、質問一覧ページヘ遷移" do
          expect{post questions_path, params: {question: question}}.to change{ Question.count }.by(+1)
          expect(flash).to be_present
          expect(response).to redirect_to questions_path
        end
      end
    end
  end
end
