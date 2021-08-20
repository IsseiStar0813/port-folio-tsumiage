class ChangeDefaultToUser < ActiveRecord::Migration[6.1]
  def change
    change_column_default :users, :tsumiage_count, to: 0
  end
end
