# frozen_string_literal: true

class GamesController < ApplicationController
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
    params[:game].each do |key, cards|
      next unless key.start_with?("card_sets_")

      card_set_id = key.split("card_sets_").last
      CardSet.find(card_set_id).update!(cards: cards)
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
end
