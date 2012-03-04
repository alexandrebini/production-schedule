# From http://theory.stanford.edu/~amitp/game-programming/a-star-flash/Pathfinder.as

class PathFinder
  # Start end Goal positions
  attr_reader :start, :goal
  
  # Alpha can be between 0 (BFS) and 1 (Dijkstra's), with 0.5 being A*
  attr_reader :alpha
  
  # The OPEN set stores the subset of objects in 'visited'
  # that are currently open; we use an unsorted list.
  attr_reader :open
  
  # The path array stores the final path, once it's found
  attr_reader :path
  
  def initialize(schema, start, goal)
    @start, @goal = start, goal
    @alpha = 0.4999
    @visited = {}
    @open = []
    @path = []
    start
    find_path
  end
  
  def start
    initial_visited = {
      :position => @start,
      :open => true,
      :closed => false,
      :parent => nil,
      :cost_from_start => 0,
      :cost_to_goal => ,
      :total_cost => 0
    }
    initial_visited[:total_cost] = total_cost_of(initial_visited)
    @open.push initial_visited
  end
  
  def find_path
    while @open.size > 0
      open.sort_by!{ |r| r.total_cost }
      best = open.shift
      best[:open] = false
      
      return if best == goal
      
      for position in best[:position].neighbors
        current_cost = best[:position].cost_to(position)

        node = {
          :position => position,
          :open => false,
          :closed => false,
          :parent => best,
          :cost_from_start => 1.0/0, # Infinity
          :cost_to_goal => 0,
          :total_cost => 0
        }
        
        # We'll consider this node if the new cost is better
        # than the old cost. The old cost starts at Infinity
        # so it's always better the first time we see this node.
        if best[:cost_from_start] + current_cost <  node[:cost_from_start]
          unless node[:open]
            node[:open] = true
            @open.push(node)
          end
          
          node[:cost_from_start] = best[:cost_from_start] + current_cost
          node[:cost_to_goal] =
          node[:total_cost] = total_cost_of(node)
        end
      end
       
    end
  end
  
  def total_cost_of(node)
    (@alpha * node[:cost_from_start] + (1-@alpha)*node[:total_cost]) / [@alpha, 1-@alpha].max
  end
  
  class << self
    
    def find(schema, start, goal)
    end
    
  end
end