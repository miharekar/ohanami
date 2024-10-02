class RegistrationsController < ApplicationController
  skip_before_action :authenticate

  def new
    referrer = Rails.application.routes.recognize_path(request.referer) || {}
    @previous_game_id = referrer[:id] if referrer[:controller] == "games"
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_path = root_path
      if params[:previous_game_id]
        game = Game.find_by(id: params[:previous_game_id])
        if game && game.owner.nil?
          params[:previous_game_id]
          redirect_path = game_path(game)
        end
      end
      session_record = @user.sessions.create!
      cookies.signed.permanent[:session_token] = {value: session_record.id, httponly: true}

      send_email_verification
      redirect_to redirect_path, notice: "Welcome! You have signed up successfully"
    else
      @previous_game_id = params[:previous_game_id]
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end

  def send_email_verification
    UserMailer.with(user: @user).email_verification.deliver_later
  end
end
