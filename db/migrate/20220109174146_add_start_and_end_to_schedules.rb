class AddStartAndEndToSchedules < ActiveRecord::Migration[6.1]
  def change
    add_column :schedules, :start, :time
    add_column :schedules, :finish, :time    
  end
end
