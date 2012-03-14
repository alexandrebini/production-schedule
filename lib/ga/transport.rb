class Transport < Array
  require "#{Rails.root}/lib/path_finder"
  
  attr_reader :schema, :roadmap, :vehicle
  
  def initialize(args={})
    raise ArgumentError.new('schema is nil') if args[:schema].nil?
    raise ArgumentError.new('roadmapmap is nil') if args[:roadmap].nil?
    @roadmap = args[:roadmap]
    @schema = args[:schema]
    @vehicle = args[:vehicle] || Vehicle.random.first
  end
  
  def find_paths!
    return self unless self.blank?
    for machine_pair in roadmap.paths
      self << PathFinder.find(
        @schema.position_of_machine(machine_pair.first),
        @schema.position_of_machine(machine_pair.last),
      )
    end
    self
  end
  
  def path_to(start_machine, goal_machine)
    return if self.blank?
    find do |r|
      r.path.first[:position].machine == start_machine && r.path.last[:position].machine == goal_machine
    end
  end
  
  def time_to(start_machine, goal_machine)
    @vehicle.time_to distance_to(start_machine, goal_machine)
  end
  
  def distance_to(start_machine, goal_machine)
    path_to(start_machine, goal_machine).path.sum do |r|
      if r[:path].nil?
        0
      else
        r[:path].distance
      end
    end
  end
  
end