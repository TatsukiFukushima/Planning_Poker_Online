class AddColumnToRoom < ActiveRecord::Migration[5.1]
  def change
    add_column :rooms, :user_id, :integer
  end
end