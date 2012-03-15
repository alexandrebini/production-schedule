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
  
  def time_to(start_machine, goal_machine)
    @vehicle.time_to distance_to(start_machine, goal_machine)
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
      new_roadmap.paths.find{ |m| m.first == r.start && m.last == r.goal }.blank?
    end
  end
  
end