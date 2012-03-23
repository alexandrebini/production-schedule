class Chromosome
  attr_reader :genes, :fitness, :schema
  attr_reader :cache, :schedule

  def initialize(args={})
    args.each { |k,v| instance_variable_set("@#{k}", v) unless v.nil? }
  
    if args[:products]
      @genes = args[:products].map do |product|
        if args[:vehicles]
          Gene.new(:product => product, :roadmap => product.roadmaps.sample, :schema => args[:schema], :vehicle => args[:vehicles].sample)
        else
          Gene.new(:product => product, :roadmap => product.roadmaps.sample)
        end
      end
    end
    
    raise ArgumentError.new('genes are nil') if @genes.nil?
    @cache ||= Cache.new
    @cache.add_products @genes.map(&:product)
    @schedule = []
  end

  def self.random(args={})
    products = args[:products] || Product.all.shuffle
    vehicles = args[:vehicles] || Vehicle.all.shuffle
    genes = products.shuffle.map do |product|
      if args[:schema]
        Gene.new(:product => product, :roadmap => product.roadmaps.sample, :schema => args[:schema], :vehicle => vehicles.sample)
      else
        Gene.new(:product => product, :roadmap => product.roadmaps.sample)
      end
    end
    Chromosome.new :genes => genes.shuffle, :schema => args[:schema], :cache => args[:cache]
  end

  def fitness
    return @fitness unless @fitness.nil? || @genes_changed
    schedule
    last_operation[:end_at] - first_operation[:start_at]
  end

  def mutate(rate)
    return if rand(100) > rate

    @genes[rand @genes.size].swap_roadmap!
    @genes_changed = true
  end

  def crossover(chromosome, rate, position=nil)
    return if rand(100) > rate

    position = rand(@genes.size - 1) if position.nil?
    position.upto(@genes.size - 1) do |index|
      first_gene = @genes[index]
      second_gene = chromosome.find_by_product_id(first_gene.product.id)
      next if second_gene.nil?

      @genes[index].swap_roadmap! second_gene.roadmap
      second_gene.swap_roadmap! first_gene.roadmap
    end
    @genes_changed = true
  end

  def find_by_product_id(product_id)
    @genes.find{ |gene| gene.product.id == product_id }
  end

  def clone
    if @schedule
      Chromosome.new :genes => @genes.map(&:clone), :genes_changed => false, :schedule => @schedule.clone, :fitness => @fitness
    else
      Chromosome.new :genes => @genes.map(&:clone)
    end
  end

  def schedule
    return @schedule unless @schedule.blank? || @genes_changed

    max_machines = @genes.map{ |r| r.roadmap.machines.size }.max.to_i

    max_machines.times do |time|
      for gene in @genes
        machine = gene.roadmap.machines[time]
        next if machine.nil?
        
        add_transport_to(gene, time) if using_transport?
        
        start_at = 0

        last_operation_of_machine = operations_of_machine(machine.id).last
        start_at = last_operation_of_machine[:end_at] if last_operation_of_machine

        last_operation_of_product = operations_of_product(gene.product.id).last
        start_at = last_operation_of_product[:end_at] if last_operation_of_product && last_operation_of_product[:end_at] > start_at

        operation_time = @cache.operation_times.of_product_and_machine(gene.product.id, machine.id)

        @schedule << { 
          :start_at => start_at, 
          :end_at => start_at + operation_time.time,
          :product_id => gene.product.id, 
          :machine_id => machine.id
        }
      end
    end
    #puts puts
    #puts "------final schedule"
    #pp @schedule
    @schedule
  end
  
  def add_transport_to(gene, index)
    puts '----add_transport_to  schedule '
    pp @schedule
    puts index
    puts
    
    current_machine = gene.roadmap.machines[index]
    last_operation_of_current_machine = operations_of_machine(current_machine.id).last
      
    return if last_operation_of_current_machine.nil? # first product skip transport
    
    previous_machine = gene.roadmap.machines[index-1]  
    last_operation_of_previous_machine = operations_of_machine(previous_machine.id).last
    
    last_operation_of_vehicle = operations_of_vehicle(gene.vehicle.id).last
    
    start_at = 0
    start_at = last_operation_of_vehicle[:end_at] if last_operation_of_vehicle
    
    last_operation_of_previous_machine_of_product = @schedule.find_all{ |r| r[:machine_id] == previous_machine.id && r[:product_id] == gene.product.id }.last
    #start_at = last_operation_of_previous_machine[:end_at] if last_operation_of_previous_machine

    start_at += last_operation_of_previous_machine_of_product[:end_at] if last_operation_of_previous_machine_of_product && last_operation_of_previous_machine_of_product[:end_at] > start_at
    
    transport_path = gene.transport.paths[index-1]
    
    if last_operation_of_vehicle && last_operation_of_vehicle[:goal_position_id] != transport_path.start.id # go back
      puts "go back"
      start_at = last_operation_of_vehicle[:end_at]
      #transport = PathFinder.new(last_operation_of_vehicle[:goal_position_id], @schema.position_of_machine(current_machine))
      #p transport
      # last_operation_of_vehicle + transport_from(last_operation_of_vehicle[:goal_position_id], position_of(current_machine) )  
    end
    
    machine_free_at = 0
    machine_free_at = last_operation_of_current_machine[:end_at] if last_operation_of_current_machine
    
    
    transport_time = gene.transport.time_to(transport_path)
    end_at = start_at + transport_time
    end_at = machine_free_at if end_at < machine_free_at
    
    @schedule << { 
      :start_at => start_at, 
      :end_at => end_at,
      :vehicle_id => gene.transport.vehicle.id,
      :product_id => gene.product.id,
      :start_position_id => transport_path.start.id,
      :goal_position_id => transport_path.goal.id
    }
    #puts '---------------------------foo', foo
    puts '------current schedule'
    pp @schedule
    puts puts
  end

  def operations_of_machine(machine_id)
    @schedule.find_all{ |r| r[:machine_id] == machine_id }
  end

  def operations_of_product(product_id)
    @schedule.find_all{ |r| r[:product_id] == product_id }
  end
  
  def operations_of_vehicle(vehicle_id)
    @schedule.find_all{ |r| r[:vehicle_id] == vehicle_id }
  end

  def first_operation
    @schedule.sort_by{ |r| r[:start_at] }.first
  end

  def last_operation
    @schedule.sort_by{ |r| r[:end_at] }.last
  end
  
  def == chromosome
    return false if self.genes.size != chromosome.genes.size
    self.genes.each_with_index do |r, i|
      return false unless r == chromosome.genes[i]
    end
    return true
  end
  
  def using_transport?
    @schema.present?
  end

end