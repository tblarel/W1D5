require_relative "../poly_node/lib/00_tree_node"

class KnightPathFinder
    attr_reader :root_node, :considered_positions

    def initialize(start_pos)
        @root_node = PolyTreeNode.new(start_pos)
        @considered_positions = [start_pos]
        build_move_tree
    end

    def build_move_tree
        queue = [self.root_node]
        i = 1
        until queue.empty?
            node = queue.shift
            new_move_positions(node.value).each do |pos|
                i += 1
                new_node = PolyTreeNode.new(pos)
                new_node.parent = node
                node.add_child(new_node)
                queue << new_node
            end
        end
        p i
    end
    
    def new_move_positions(pos)
        
        actual_moves = []

        valid_moves(pos).each do |move|
            if !self.considered_positions.include?(move) 
                actual_moves << move
                self.considered_positions << move 
            end
        end
        actual_moves
    end

    def valid_moves(pos)
        all_moves = [[1,2],[2,1],[2,-1],[1,-2],[-1,-2],[-2,-1],[-2,1],[-1,2]]
        
        possible_moves = []
        
        all_moves.each do |spot|
            x = pos[0] + spot[0]
            y = pos[1] + spot[1]
            if x > 0 && x < 8 && y > 0 && y < 8
                possible_moves << [x,y]
            end
        end

        possible_moves
    end


end

a = KnightPathFinder.new([0,0])
