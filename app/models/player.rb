class Player < ApplicationRecord
  belongs_to :game, touch: true
  has_many :card_sets, dependent: :destroy
end

# == Schema Information
#
# Table name: players
#
#  id         :binary(16)       not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  game_id    :binary(16)       not null
#
# Indexes
#
#  index_players_on_game_id  (game_id)
#  index_players_on_id       (id) UNIQUE
#
# Foreign Keys
#
#  game_id  (game_id => games.id)
#
