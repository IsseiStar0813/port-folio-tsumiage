class AddTsumiageCountToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :tsumiage_count, :integer
  end
end
