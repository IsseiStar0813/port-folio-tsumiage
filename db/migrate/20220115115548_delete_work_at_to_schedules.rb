class DeleteWorkAtToSchedules < ActiveRecord::Migration[6.1]
  def change
    remove_column :schedules, :work_at, :date
  end
end
