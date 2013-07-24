require "factory"
require_relative "./application_controller"

class GameController < ApplicationController

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
        session[:player_turn] = :player1
        
        self.update
    end

    def update
        @move = params[:move]
        @board = session[:game]
        @player_turn = session[:player_turn]
        @current_player = session[@player_turn]
        
        while(!@board.game_over?)
            if @current_player.type == :human && @move == nil
                break
            elsif @current_player.type == :human
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

        if @board.game_over?
            @winner = self.get_winner(@board)
        end
        
        render action: :update
    end


    def get_winner board
       winner_symbol = board.check_board_status
       if session[:player1].symbol == winner_symbol
            :player1 
       elsif session[:player2].symbol == winner_symbol
           :player2
       elsif winner_symbol == :tie
           :tie
       end 
    end

    def opponent player
        if player == :player1 then :player2
        else :player1 end
    end

end
