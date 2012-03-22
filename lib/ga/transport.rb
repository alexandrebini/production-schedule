class Transport
  require "#{Rails.root}/lib/path_finder"
  
  attr_reader :schema, :roadmap, :vehicle, :paths
  
  def initialize(args={})
    raise ArgumentError.new('schema is nil') if args[:schema].nil?
    raise ArgumentError.new('roadmapmap is nil') if args[:roadmap].nil?
    @roadmap = args[:roadmap]
    @schema = args[:schema]
    @vehicle = args[:vehicle] || Vehicle.random.first
  end
  
  def paths
    return @paths unless @paths.blank?
    @paths = []
    for machine_pair in roadmap.paths
      @paths << PathFinder.find(
        @schema.position_of_machine(machine_pair.first),
        @schema.position_of_machine(machine_pair.last),
      )
    end
    @paths
  end
  
  def path_to(start_machine, goal_machine)
    return if self.blank?
    paths.find do |r|
      r.first[:position].machine == start_machine && r.last[:position].machine == goal_machine
    end
  end
  
  def time_to(args)
    if args.is_a?(PathFinder)
      @vehicle.time_to distance_to(args.start.machine, args.goal.machine)
    else
      @vehicle.time_to distance_to(args[:start], args[:goal])
    end
  end
  
  def distance_to(start_machine, goal_machine)
    path_to(start_machine, goal_machine).sum do |r|
      if r[:path].nil?
        0
      else
        r[:path].distance
      end
    end
  end
  
  def roadmap=new_roadmap
    current_paths = paths
    current_paths.delete_if do |r|
      new_roadmap.paths.find do |machine_pairs| 
        @schema.position_of_machine(machine_pairs.first) == r.start && 
        @schema.position_of_machine(machine_pairs.last) == r.goal
      end.blank?
    end
    
    new_roadmap.paths.each_with_index do |machine_pairs, index|
      start_position = @schema.position_of_machine(machine_pairs.first)
      goal_position = @schema.position_of_machine(machine_pairs.last)
      
      next if current_paths[index].present? && 
        current_paths[index].start == start_position && 
        current_paths[index].goal == goal_position

      current_paths.insert index, PathFinder.find(start_position, goal_position)
    end
    
    @roadmap = new_roadmap
    @paths = current_paths
  end
  
end