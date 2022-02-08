require 'rails_helper'

RSpec.describe Answer, type: :model do
  let(:user) {FactoryBot.create(:user)}
  let(:question) { create(:question, user_id: user.id) }
  let!(:answer) { build(:answer, question_id: question.id) }
  describe "バリデーション" do
    subject { test_answer.valid? }
    let (:test_answer) { answer }

    context "contentが空白の場合" do
      it "バリデーションで無効" do
        test_answer.content = ""
        is_expected.to eq false;
      end
    end
  end
end
