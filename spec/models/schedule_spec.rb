require 'rails_helper'

RSpec.describe Schedule, type: :model do
  let(:user) {FactoryBot.create(:user)}
  let!(:schedule) { build(:schedule, user_id: user.id) }
  describe "バリデーション" do
    subject { test_schedule.valid? }
    let(:test_schedule) { schedule }
    context "taskカラムが空欄の場合" do
      it 'バリデーションで無効' do
        test_schedule.task = ""
        is_expected.to eq false;
      end
    end
    context "user_id カラムが空欄の場合" do
      it "バリデーションで無効" do
        test_schedule.user_id = ""
        is_expected.to eq false;
      end
    end
  end
end
