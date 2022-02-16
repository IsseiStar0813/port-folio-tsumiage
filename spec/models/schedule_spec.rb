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
    context "total_hours カラムが空欄の場合" do
      it "バリデーションで無効" do
        test_schedule.total_hours = ""
        is_expected.to eq false;
      end
    end
    context "total_minutes カラムが空欄の場合" do 
      it "バリデーションで無効" do
        test_schedule.total_minutes = ""
        is_expected.to eq false;
      end
    end
    context "開始時刻が終了時刻より遅い場合" do
      it "バリデーションで無効" do
        test_schedule.start = "13:00:00"
        is_expected.to eq false;
      end
    end
    context "startカラムが空欄の場合" do
      it "バリデーションで無効" do
        test_schedule.start = ""
        is_expected.to eq false;
      end
    end
    context "finishカラムが空欄の場合" do
      it "バリデーションで無効" do
        test_schedule.finish = ""
        is_expected.to eq false;
      end
    end
  end
end
