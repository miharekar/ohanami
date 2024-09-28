class DropNameFromGame < ActiveRecord::Migration[7.1]
  def change
    remove_column :games, :name, :string
  end
end
