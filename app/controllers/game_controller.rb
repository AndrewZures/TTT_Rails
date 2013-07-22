require "two_dimensional_board"
require "computer_ai"

class GameController < ApplicationController

    def new_game
        session[:game] = TwoDimensionalBoard.new(4)
        @board = session[:game]
        session[:ai] = ComputerAI.new(:o, 100)
        results = @board.get_print_results
        @board_array = results[0];
        @row_length = results[1];
    end

    def get_board
        @board.get_print_results
    end

    def update
        @move = params[:move].to_i
        @board = session[:game]
        @ai = session[:ai]
        @board.record_choice(@move, :x)
        if (@board.check_board_status == :continue_game)
            @ai_move = @ai.make_move(@board)
        end

        results = @board.get_print_results
        @board_array = results[0];
        @row_length = results[1];
    end



end
