class DropCalenderModel < ActiveRecord::Migration[6.1]
  def change
    drop_table :calenders
  end
end
