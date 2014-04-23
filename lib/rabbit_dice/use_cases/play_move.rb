module RabbitDice
  class PlayMove < UseCase
    def run(params)
      game = RabbitDice.db.get_game(params[:game_id])
      return failure :invalid_game_id if game.nil?
      return failure :invalid_move unless params[:move].match /^roll_dice|stop$/

      if params[:move] == 'roll_dice'
        current_turn = game.turns.last
        roll = game.dice_cup.roll
        current_turn.rolls.push(roll)

        if current_turn.over?
          game.end_turn
        end
      elsif params[:move] == 'stop'
        game.end_turn
      end

      success :game => game
    end
  end
end
