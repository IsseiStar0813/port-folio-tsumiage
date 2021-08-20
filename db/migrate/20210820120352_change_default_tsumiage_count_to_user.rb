class ChangeDefaultTsumiageCountToUser < ActiveRecord::Migration[6.1]
  def change
    change_column_default :users, :tsumiage_count, from: nil, to: 0
  end
end
