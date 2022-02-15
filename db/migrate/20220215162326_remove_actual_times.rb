class RemoveActualTimes < ActiveRecord::Migration[6.1]
  def change
    remove_column :schedules, :actual_hours, :integer
    remove_column :schedules, :actual_minutes, :integer
  end
end
