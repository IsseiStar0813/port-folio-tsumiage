class ChangeDataAchievedBoolean < ActiveRecord::Migration[6.1]
  def change
    change_column :schedules, :achieved, :boolean, default:false
  end
end
