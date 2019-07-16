class CreateRoomIssues < ActiveRecord::Migration[5.1]
  def change
    create_table :room_issues do |t|
      t.references :room, foreign_key: true
      t.references :issue, foreign_key: true

      t.timestamps
    end
  end
end
