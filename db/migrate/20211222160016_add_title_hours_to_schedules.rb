class AddTitleHoursToSchedules < ActiveRecord::Migration[6.1]
  def change
    add_column :schedules, :task, :string
    add_column :schedules, :hours, :integer
  end
end
