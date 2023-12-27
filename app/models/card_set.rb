class CardSet < ApplicationRecord
  belongs_to :player

  COLOR_VALUES = {
    blue: 3,
    green: 4,
    gray: 7,
  }

  def cards
    super.presence || 0
  end

  def value
    if color == 'pink'
      cards * (cards + 1) / 2
    else
      cards * COLOR_VALUES[color.to_sym]
    end
  end
end

# == Schema Information
#
# Table name: card_sets
#
#  id         :integer          not null, primary key
#  cards      :integer
#  color      :string
#  round      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  player_id  :integer          not null
#
# Indexes
#
#  index_card_sets_on_player_id  (player_id)
#
# Foreign Keys
#
#  player_id  (player_id => players.id)
#
