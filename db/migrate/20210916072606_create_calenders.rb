class CreateCalenders < ActiveRecord::Migration[6.1]
  def change
    create_table :calenders do |t|

      t.datetime :start_time

      t.timestamps
    end
  end
end
