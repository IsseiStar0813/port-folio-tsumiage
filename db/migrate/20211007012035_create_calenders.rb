class CreateCalenders < ActiveRecord::Migration[6.1]
  def change
    create_table :calenders do |t|
      t.references :user, foreign_key: true
      t.datetime :start_time
      t.boolean :tsumiage

      t.timestamps
    end
  end
end
