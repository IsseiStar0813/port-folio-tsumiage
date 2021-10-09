class RemovecolumnsFromCalenders < ActiveRecord::Migration[6.1]
  def change 
      remove_column :calenders, :posted, :string
  end
end
