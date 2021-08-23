class AddAlreadyPostedToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :already_posted, :boolean, default: false, null: false
  end
end
