require_relative 'tic_tac_toe.rb'
require "byebug"

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)

  end

  def winning_node?(evaluator)

  end

  # def switch_mark
  #   if @next_mover_mark == :x
  #     @next_mover_mark = :o    
  #   else
  #     @next_mover_mark = :x
  #   end
  # end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    children_nodes = []
    if prev_move_pos != nil
      new_mover_mark = @board[prev_move_pos[0], prev_move_pos[1]]
    else
      new_mover_mark = :o
    end

    @board.rows.each_with_index do |row, row_idx|
      row.each_with_index do |spot, col_idx|
        if @board.empty?([row_idx, col_idx])
          new_board = @board.dup
          new_board[[row_idx, col_idx]] = @next_mover_mark
          children_nodes << TicTacToeNode.new(new_board, new_mover_mark, [row_idx, col_idx])
        end
      end
    end
    children_nodes
  end
end

b = Board.new
node = TicTacToeNode.new(b, :x)
p node.children

