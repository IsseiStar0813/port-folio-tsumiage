class AddActualTimesToScedules < ActiveRecord::Migration[6.1]
  def change
    add_column :schedules, :actual_hours, :integer
    add_column :schedules, :actual_minutes, :integer
  end
end
