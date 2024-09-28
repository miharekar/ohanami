class AddUniqueIndexToCardSets < ActiveRecord::Migration[7.1]
  def change
    add_index :card_sets, %i[round color player_id], unique: true
  end
end
