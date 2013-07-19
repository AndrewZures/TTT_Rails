require "two_dimensional_board"

class GameController < ApplicationController

    def new_game
        @board = TwoDimensionalBoard.new(3)
        results = @board.get_print_results
        @board_array = results[0];
        @row_length = results[1];
    end

    def get_board
        @board.get_print_results
    end


end
