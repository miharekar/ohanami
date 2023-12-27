# frozen_string_literal: true

class CreateCardSets < ActiveRecord::Migration[7.1]
  def change
    create_table :card_sets do |t|
      t.references :player, null: false, foreign_key: true
      t.integer :round
      t.integer :cards
      t.string :color

      t.timestamps
    end
  end
end
