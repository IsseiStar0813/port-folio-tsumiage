class AddTotalTimesToSchedules < ActiveRecord::Migration[6.1]
  def change
    add_column :schedules, :total_hours, :integer
    add_column :schedules, :total_minutes, :integer
  end
end
