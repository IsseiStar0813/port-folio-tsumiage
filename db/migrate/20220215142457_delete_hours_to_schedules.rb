class DeleteHoursToSchedules < ActiveRecord::Migration[6.1]
  def change
    remove_column :schedules, :hours, :integer
  end
end
