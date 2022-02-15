class AddTotalTimesToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :total_times, :integer
  end
end
