class PolyTreeNode

    attr_reader :parent, :children, :value

    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end

    def parent=(node)
        if !self.parent.nil?
            self.parent.children.delete(self)
        end

       @parent = node

        if !node.nil? && !node.children.include?(self)
            node.children << self 
        end
    end

    def add_child(child_node)
        self.children << child_node if !self.children.include?(child_node)
        child_node.parent = self
    end

    def remove_child(child_node)
        if self.children.include?(child_node) 
            self.children.delete(child_node)
            child_node.parent = nil
        else
            raise "That aint my kid!"
        end
    end

    def dfs(target_value)
        return self if self.value == target_value
        self.children.each do |child|
            result = child.dfs(target_value)
            return result unless result.nil?
        end
        nil
    end

    def bfs(target_value)
        queue = [self]
        until queue.empty?
            node = queue.shift
            return node if node.value == target_value
            node.children.each {|child| queue << child}
        end
        nil
    end

    def inspect
        { 'value' => @value, 'parent_value' => @parent.value }.inspect
    end

end
