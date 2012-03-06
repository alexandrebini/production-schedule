class Transport
  require "#{Rails.root}/lib/path_finder"
  
  attr_reader :schema, :roadmap, :vehicle, :paths
  
  def initialize(args={})
    raise ArgumentError.new('schema is nil') if args[:schema].nil?
    raise ArgumentError.new('roadmap is nil') if args[:roadmap].nil?
    @roadmap = args[:roadmap]
    @schema = args[:schema]
    @vehicle = args[:vehicle] || Vehicle.random.first
  end
  
  def find_path
    return @paths unless @paths.nil?
    @paths = []
    for machine_pair in machine_pairs
      @paths << PathFinder.find(
        @schema.position_of_machine(machine_pair.first),
        @schema.position_of_machine(machine_pair.last),
      )
    end
    @paths
  end
  
  def machine_pairs
    return @machine_pairs unless @machine_pairs.nil?
    @machine_pairs = []
    @roadmap.machines.each_with_index do |machine, index|
      break if index == @roadmap.machines.size - 1
      @machine_pairs << [machine, @roadmap.machines[index+1]]
    end
    @machine_pairs
  end
end