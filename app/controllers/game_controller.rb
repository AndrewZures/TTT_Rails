require "factory"

class GameController < ApplicationController

    def get_board
        @board.get_print_results
    end

    def setup_new_game parameters
        factory = Factory.new
        session[:game] = factory.get_board(params[:game_type.to_sym])
        session[:player1] = factory.get_player(params[:player1].to_sym, :o)
        session[:player2] = factory.get_player(params[:player2], :x)
        session[:current_player] = :player1
    end

    def update
        if params[:game_type] != nil
            session[:game] = nil
            factory = Factory.new
            session[:game] = factory.get_board(params[:game_type].to_sym)
            session[:player1] = factory.get_player(params[:player1].to_sym, :o)
            session[:player2] = factory.get_player(params[:player2].to_sym, :x)
            session[:current_player] = :player1

        else
            
            @move = params[:move].to_i
            @board = session[:game]
            if session[:current_player] == :player1
                @current_player = session[:player1]
                if @current_player.get_player_type == :human
                    @board.record_choice(@move, @current_player.symbol)
                else
                    @current_player.make_move(@board)
                end
            else
                @current_player = session[:player2]
                if @current_player.get_player_type == :human
                    @board.record_choice(@move, @current_player.symbol)
                else
                    @current_player.make_move(@board)
                end
            end
            session[:current_player] = opponent(session[:current_player])



        end

        @board = session[:game]
        results = @board.get_print_results
        @board_array = results[0];
        @row_length = results[1];
        

        render action: :update
    end

    def opponent player
        if player == :player1 then :player2
        else :player1 end
    end



end
