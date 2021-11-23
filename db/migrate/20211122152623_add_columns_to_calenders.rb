class AddColumnsToCalenders < ActiveRecord::Migration[6.1]
  def change
    add_column :calenders, :start_time, :datetime
    add_reference :calenders, :user, null: false, foreign_key: true

  end
end
