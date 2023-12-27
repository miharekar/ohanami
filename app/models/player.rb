class Player < ApplicationRecord
  belongs_to :game
  has_many :card_sets, dependent: :destroy
end

# == Schema Information
#
# Table name: players
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  game_id    :integer          not null
#
# Indexes
#
#  index_players_on_game_id  (game_id)
#
# Foreign Keys
#
#  game_id  (game_id => games.id)
#
