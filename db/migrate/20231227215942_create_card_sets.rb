class CreateCardSets < ActiveRecord::Migration[7.1]
  def change
    create_table :card_sets, id: false do |t|
      t.binary :id, limit: 16, null: false, index: {unique: true}, primary_key: true
      t.references :player, foreign_key: true, index: true, type: :binary, limit: 16, null: false
      t.integer :round
      t.integer :cards
      t.string :color

      t.timestamps
    end
  end
end
