class CreateSessions < ActiveRecord::Migration[7.1]
  def change
    create_table :sessions, id: false do |t|
      t.binary :id, limit: 16, null: false, index: {unique: true}, primary_key: true
      t.references :user, null: false, foreign_key: true, index: true, type: :binary, limit: 16
      t.string :user_agent
      t.string :ip_address

      t.timestamps
    end
  end
end
