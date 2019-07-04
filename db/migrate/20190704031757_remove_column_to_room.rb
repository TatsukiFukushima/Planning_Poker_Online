class RemoveColumnToRoom < ActiveRecord::Migration[5.1]
  def change
    remove_column :rooms, :room_id, :integer
  end
end
