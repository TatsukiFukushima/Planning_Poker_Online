class AddPointToIssue < ActiveRecord::Migration[5.1]
  def change
    add_column :issues, :point, :string
  end
end
