class AddPostedColumnToCalenders < ActiveRecord::Migration[6.1]
  def change
    add_column :calenders, :posted, :string
  end
end
