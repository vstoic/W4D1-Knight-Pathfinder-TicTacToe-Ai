class PolyTreeNode
    def initialize(value)
        @parent = nil
        @children = []
        @value = value
    end

    attr_reader :parent, :children, :value

    def parent=(p_node)
        return if @parent == p_node
        
        unless p_node == nil
            p_node.children << self
        end

        unless @parent == nil
            @parent.children.delete(self)
        end

        @parent = p_node
    end

    def add_child(child_node)
        child_node.parent = (self)  
    end

    def remove_child(child_node)
        raise "error" if !self.children.include?(child_node)
        child_node.parent = nil
    end

    def dfs(target)
        return self if self.value == target

        self.children.each do |child|
            temp = child.dfs(target)
            return temp unless temp == nil
        end

        nil
    end

    def bfs(target)
        return self if self.value == target

        nodes_queue = [self]
        until nodes_queue.empty?
            current_node = nodes_queue.shift
            return current_node if current_node.value == target
            nodes_queue += current_node.children
        end

        nil
    end
end