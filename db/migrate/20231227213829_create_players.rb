class CreatePlayers < ActiveRecord::Migration[7.1]
  def change
    create_table :players, id: false do |t|
      t.binary :id, limit: 16, null: false, index: {unique: true}, primary_key: true
      t.references :game, foreign_key: true, index: true, type: :binary, limit: 16, null: false
      t.string :name

      t.timestamps
    end
  end
end
