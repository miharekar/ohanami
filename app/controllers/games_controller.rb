class GamesController < ApplicationController
  prepend MemoWise

  before_action :set_game, only: %i[show update]

  def index
    return unless Current.user

    @previous_games = Current.user.games.order(created_at: :desc).limit(20)
  end

  def show
    return unless Current.user

    @previous_games = Current.user.games.previous(@game).limit(20)
  end

  def new
    if existing_game
      game = existing_game.dup
      game.owner = Current.user
      if game.save
        game.players = existing_game.players.map(&:dup)
        return redirect_to game
      end
    end

    @game = Game.new
  end

  def create
    @game = Game.new({owner: Current.user})

    params[:game].each do |key, name|
      next if !key.start_with?("player_") || name.blank?

      @game.players << Player.new(name:)
    end

    if @game.players.size > 1 && @game.save
      redirect_to @game
    else
      redirect_to new_game_path, notice: "Game must have at least two players."
    end
  end

  # rubocop:disable Rails/SkipsModelValidations
  def update
    if card_set_updates.any?
      CardSet.upsert_all(card_set_updates, unique_by: :id)
      @game.touch
    end

    redirect_to @game
  end
  # rubocop:enable Rails/SkipsModelValidations

  private

  def set_game
    @game = Game.find(params[:id])
  end

  memo_wise def existing_game
    return if params[:from].blank?

    Game.find_by(id: params[:from])
  end

  memo_wise def card_set_updates
    card_sets = @game.card_sets.to_h { |card_set| [card_set.id, card_set.attributes] }
    updates = []
    params[:game].each do |key, cards|
      next unless key.start_with?("card_sets_")

      id = key.split("card_sets_").last
      cards = cards.to_i
      old_cards = params[:game]["old_card_sets_#{id}"].to_i
      next if card_sets[id].blank? || card_sets[id]["cards"] == cards || old_cards == cards

      updates << card_sets[id].merge("cards" => cards, "updated_at" => Time.current)
    end
    updates
  end
end
