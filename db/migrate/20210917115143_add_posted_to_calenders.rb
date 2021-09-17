class AddPostedToCalenders < ActiveRecord::Migration[6.1]
  def change
    add_column :calenders, :posted, :boolean, default: false, null: false
  end
end
