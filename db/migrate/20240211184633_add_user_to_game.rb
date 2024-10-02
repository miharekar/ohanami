class AddUserToGame < ActiveRecord::Migration[7.1]
  def change
    add_reference :games, :user, foreign_key: true, index: true, type: :binary, limit: 16
  end
end
