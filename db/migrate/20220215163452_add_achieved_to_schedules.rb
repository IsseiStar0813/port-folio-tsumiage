class AddAchievedToSchedules < ActiveRecord::Migration[6.1]
  def change
    add_column :schedules, :achieved, :boolean, default: false
  end
end
