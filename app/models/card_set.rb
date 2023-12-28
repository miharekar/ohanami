# frozen_string_literal: true

class CardSet < ApplicationRecord
  belongs_to :player, touch: true

  COLOR_VALUES = {"blue" => 3, "green" => 4, "gray" => 7}.freeze

  def cards
    super.presence || 0
  end

  def value
    if color == "pink"
      cards * (cards + 1) / 2
    else
      cards * COLOR_VALUES[color]
    end
  end
end

# == Schema Information
#
# Table name: card_sets
#
#  id         :binary(16)       not null, primary key
#  cards      :integer
#  color      :string
#  round      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  player_id  :binary(16)       not null
#
# Indexes
#
#  index_card_sets_on_id                             (id) UNIQUE
#  index_card_sets_on_player_id                      (player_id)
#  index_card_sets_on_round_and_color_and_player_id  (round,color,player_id) UNIQUE
#
# Foreign Keys
#
#  player_id  (player_id => players.id)
#
