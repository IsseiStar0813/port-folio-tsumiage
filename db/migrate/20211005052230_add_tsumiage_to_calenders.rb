class AddTsumiageToCalenders < ActiveRecord::Migration[6.1]
  def change
    add_column :calenders, :tsumiage, :boolean, default: false, null: false
  end
end
