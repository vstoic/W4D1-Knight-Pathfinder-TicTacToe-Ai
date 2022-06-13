require_relative './00_tree_node.rb'

class KnightPathFinder
    def self.valid_moves(pos)
        new_possible =[
            [-1,-2],
            [-1, 2],
            [-2,-1],
            [-2, 1],
            [1, -2],
            [1, 2],
            [2, -1],
            [2, 1],
        ]
        valid_moves = []
        new_possible.each do |mod|
            sub_pos = []
            sub_pos << pos[0] + mod[0]
            sub_pos << pos[1] + mod[1]
            valid_moves << sub_pos
        end
        valid_moves.select do |move|
           move.all? {|idx| (0..7).include?(idx)}
        end
    end

    attr_reader :root_node, :considered_pos
    
    def initialize(start_pos)
        @start_position = start_pos
        @root_node = PolyTreeNode.new(start_pos)
        @considered_pos = [start_pos]
        build_move_tree
    end

    def new_move_positions(pos)
        new_moves = []
       possible = KnightPathFinder.valid_moves(pos)
       possible.each do |target| 
        if !@considered_pos.include?(target)
            new_moves << target
            @considered_pos << target
        end
       end
       new_moves
    end

    def build_move_tree
        que = [@root_node]

        until que.empty?
        
            current_pos = que.first.value
            current_node = que.shift
            new_moves = new_move_positions(current_pos)
            new_moves.each do |pos|
                new_node = PolyTreeNode.new(pos)
                current_node.add_child(new_node)
                que << new_node
            end
        end
    end

    def find_path(end_pos)
        end_node = @root_node.bfs(end_pos)
        trace_path_back(end_node)
    end

    def trace_path_back(end_node)
        parent_path = [end_node]
        until parent_path[0] == @root_node
            current_node = parent_path[0]
            parent_path.unshift(current_node.parent)
        end
        parent_path.map { |node| node.value }
    end
end

p kpf = KnightPathFinder.new([0, 0])
p kpf.find_path([7, 6]) # => [[0, 0], [1, 2], [2, 4], [3, 6], [5, 5], [7, 6]]
p kpf.find_path([6, 2]) # => [[0, 0], [1, 2], [2, 0], [4, 1], [6, 2]]

