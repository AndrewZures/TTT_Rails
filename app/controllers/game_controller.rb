require "factory"

class GameController < ApplicationController

    def get_board
        @board.get_print_results
    end

    def new_game
        factory = Factory.new
        session[:game] = factory.get_board(params[:game_type].to_sym)
        session[:player1] = factory.get_player(params[:player1].to_sym, :o)
        session[:player2] = factory.get_player(params[:player2].to_sym, :x)
        session[:player_turn] = :player1

        self.update
    end

    def restart_game
        @board = session[:game]
        @board.reset_board
        
        self.update
    end

    def update
        @move = params[:move]
        @board = session[:game]
        @player_turn = session[:player_turn]
        @current_player = session[@player_turn]
        
        while(!@board.game_over?)
            if @current_player.get_player_type == :human && @move == nil
                break
            elsif @current_player.get_player_type == :human
                @board.record_choice(@move.to_i, @current_player.symbol)
                @move = nil
            else
                @current_player.make_move(@board)
                @move = nil
            end

            @player_turn = opponent(@player_turn) 
            session[:player_turn] = @player_turn
            @current_player = session[@player_turn]
        end
        
        render action: :update
    end

    

    def opponent player
        if player == :player1 then :player2
        else :player1 end
    end

end
