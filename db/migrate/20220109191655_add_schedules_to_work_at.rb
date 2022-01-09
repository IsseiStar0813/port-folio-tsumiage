class AddSchedulesToWorkAt < ActiveRecord::Migration[6.1]
  def change
    add_column :schedules, :work_at, :date
  end
end
