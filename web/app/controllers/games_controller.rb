class GamesController < ApplicationController

  def new

  end

  def create
    @result = RabbitDice::CreateGame.run(:id => params[:id].to_i, :players => params[:players])
    if @result.success?
      flash[:success] = "Game has been created!"

      redirect_to "games/#{@result.game.id}"
    else
      @error = @result.error
      render 'new'
    end
  end

  def show
  end


end
