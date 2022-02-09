require 'rails_helper'

RSpec.describe "Answers_controller", type: :request do
  let(:user) {FactoryBot.create(:user)}
  let(:question) { create(:question, user_id: user.id) }
  let!(:answer) { FactoryBot.attributes_for(:answer, question_id: question.id) }
  let(:answer_brank_content) {FactoryBot.attributes_for(:answer, question_id: question.id, content: "")}
  describe "#new" do
    context "ログインしていない場合" do
      it "ログインページへリダイレクト" do
        get new_answer_path
        expect(flash).to be_present
        expect(response).to redirect_to login_url
      end
    end

    context "ログインしている場合" do
      before do sign_in(user) end
      context "params[:question]が存在する場合" do
        it "質問回答ページを表示" do
          get new_answer_path(question: question.id)
          expect(response).to have_http_status "200"
          expect(response).to render_template("new")
        end
      end

      context "params[:question]が存在しない場合" do
        it "プロフィールページへリダイレクト" do
          get new_answer_path
          expect(response).to redirect_to user
        end
      end
    end
  end

  describe "#create" do
    context "ログインしていない場合" do
      it "ログインページへリダイレクト" do
        post answers_path
        expect(flash).to be_present
        expect(response).to redirect_to login_url
      end
    end

    context "ログインしている場合" do
      before do sign_in(user) end
      
      context "contentが空白の場合" do
        it "回答を作成せず、もう一度回答作成ページをレンダリング" do
          post answers_path, params: {answer: answer_brank_content, question: question.id}
          expect(response).to render_template "shared/_error_message"
          expect(response).to render_template "new"
        end
      end

      context "有効な内容の場合" do
        it "質問への回答を投稿,質問一覧ページへ遷移" do
          expect{post answers_path, params: {answer: answer, question: question.id }}.to change{ Answer.count }.by(+1)
          expect(flash).to be_present
          expect(response).to redirect_to questions_path
        end
      end
    end
  end
end
