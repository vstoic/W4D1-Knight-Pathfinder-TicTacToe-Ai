

class KnightPathFinder
    def self.root_node(pos)
        PolyTreeNode.new(pos) 
    end

    def self.valid_moves(pos)

    end

    attr_reader :root_node, :considered_pos
    
    def initialize(start_pos)
        @start_position = start_pos
        @root_node = self.root_node(start_pos)
        @considered_pos = [start_pos]
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






end