class Game < ApplicationRecord
  prepend MemoWise

  COLOR_ROUNDS = {1 => %i[blue], 2 => %i[blue green], 3 => %i[blue green gray pink]}.freeze

  has_many :players, dependent: :destroy
  has_many :card_sets, through: :players

  broadcasts_refreshes

  def prepare_color_rounds!
    card_set_attributes = COLOR_ROUNDS.flat_map do |round, colors|
      colors.product(players).map do |color, player|
        {id: UUID7.generate, round:, color:, player_id: player.id, created_at: Time.current, updated_at: Time.current}
      end
    end

    CardSet.upsert_all(card_set_attributes, unique_by: %i[round color player_id])
  end

  memo_wise def card_sets_by_round_and_color_and_player
    prepare_color_rounds! if card_sets.none?
    card_sets.index_by { |c| [c.round, c.color, c.player_id] }
  end

  memo_wise def score_by_player_id
    card_sets.group_by(&:player_id).transform_values { |card_sets| card_sets.sum(&:value) }
  end
end

# == Schema Information
#
# Table name: games
#
#  id         :binary(16)       not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :binary(16)
#
# Indexes
#
#  index_games_on_id       (id) UNIQUE
#  index_games_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
