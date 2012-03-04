# From http://theory.stanford.edu/~amitp/game-programming/a-star-flash/Pathfinder.as

class PathFinder
  INFINITY = 1 << 32
  
  # Start end Goal positions
  attr_reader :start, :goal
    
  # The OPEN set stores the subset of objects in 'visited'
  # that are currently open; we use an unsorted list.
  attr_reader :open
  
  # The path array stores the final path, once it's found
  attr_reader :path
  
  def initialize(start, goal)
    @start, @goal = start, goal
    @visited = []

    @open = [{ :position => @start, :parent => nil, :cost_from_start => 0 }]
    
    @path = [find]
    begin
      @path << @path.last[:parent]
    end while @path.last[:parent]
    @path.reverse!
  end
  
  def find
    while @open.size > 0
      @open.sort_by!{ |r| r[:cost_from_start] }
      best = open.shift
      @visited.push best
      
      return best if best[:position] == goal
      
      for position in best[:position].neighbors
        next if @visited.find{ |r| r[:position] == position }
        
        path = best[:position].path_to(position)
        
        @open.push({
          :position => position,
          :parent => best,
          :path => path,
          :cost_from_start => best[:cost_from_start] + path.distance
        })
      end
       
    end
  end
  
  def total_cost
    @path.last[:cost_from_start]
  end
  
  class << self
    def find(start, goal)
      PathFinder.new(start, goal)
    end
  end
end