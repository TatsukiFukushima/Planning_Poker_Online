class AddAboutToRoom < ActiveRecord::Migration[5.1]
  def change
    add_column :rooms, :about, :string
  end
end
