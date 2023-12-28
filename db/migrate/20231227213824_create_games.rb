# frozen_string_literal: true

class CreateGames < ActiveRecord::Migration[7.1]
  def change
    create_table :games, id: false do |t|
      t.binary :id, limit: 16, null: false, index: {unique: true}, primary_key: true
      t.string :name

      t.timestamps
    end
  end
end
