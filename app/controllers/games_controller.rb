# frozen_string_literal: true

class GamesController < ApplicationController
  prepend MemoWise

  before_action :set_game, only: %i[show update]

  def index
    @games = Game.order(created_at: :desc)
  end

  def show
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)

    params[:game].each do |key, name|
      next if !key.start_with?("player_") || name.blank?

      @game.players << Player.new(name: name)
    end

    if @game.players.size > 1 && @game.save
      redirect_to @game
    else
      redirect_to new_game_path, notice: "Game must have at least two players."
    end
  end

  def update
    if card_set_updates.any?
      CardSet.upsert_all(card_set_updates, unique_by: :id)
      @game.touch
    end

    redirect_to @game
  end

  private

  def set_game
    @game = Game.find(params[:id])
  end

  def game_params
    params.require(:game).permit(:name)
  end

  memo_wise def card_set_updates
    card_sets = @game.card_sets.to_h { |card_set| [card_set.id, card_set.attributes] }
    updates = []
    params[:game].each do |key, cards|
      next unless key.start_with?("card_sets_")

      id = key.split("card_sets_").last
      cards = cards.to_i
      next if card_sets[id].blank? || card_sets[id]["cards"] == cards

      updates << card_sets[id].merge("cards" => cards, "updated_at" => Time.current)
    end
    updates
  end
end
