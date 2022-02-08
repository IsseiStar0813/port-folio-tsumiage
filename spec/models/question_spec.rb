require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:user) {FactoryBot.create(:user)}
  let!(:question) { build(:question, user_id: user.id) }
  describe "バリデーション" do
    subject { test_question.valid? }
    let(:test_question) { question }

    context "titleが空欄の場合" do
      it "バリデーションで無効" do
        test_question.title = ""
        is_expected.to eq false;
      end
    end

    context "contentが空欄の場合" do
      it "バリデーションで無効" do
        test_question.content = ""
        is_expected.to eq false;
      end
    end
  end
end
