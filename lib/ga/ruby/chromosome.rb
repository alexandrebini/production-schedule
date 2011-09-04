class Chromosome
  attr_reader :genes

  def initialize(args={})
    raise ArgumentError.new("genes are nil") if args[:genes].nil?
    @genes = args[:genes]
  end

  def self.random(products = nil)
    products ||= Product.all
    Chromosome.new :genes => products.shuffle.map(&:to_gene)
  end

  def to_a
    @genes.map(&:to_a).flatten
  end

  def fitness
    rand 9999
  end

  def mutate(rate)
    return if rand(100) > rate
    @genes[rand @genes.size].swap_roadmap!
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
  end

  def find_by_product_id(product_id)
    @genes.find{ |gene| gene.product.id == product_id }
  end

  def clone
    Chromosome.new :genes => @genes.map(&:clone)
  end

  def to_schedule
    schedule = Schedule.new

    max = @genes.map{ |r| r.roadmap.machines.count }.max
    puts "max: #{ max }"
    puts "----roadmaps"
    @genes.each{|r| puts "produto: #{r.product.id} \trotas: #{ r.roadmap.machines.map(&:id)}" }
    puts
    max.times do |time|
      for gene in @genes
        machine = gene.roadmap.machines[time]
        next if machine.nil?
        start_at = 0

        puts "###### produto: #{gene.product.id}     maquina: #{machine.id}"

        last_operation_of_machine = schedule.operations_of_machine(machine.id).last
        start_at = last_operation_of_machine.end_at if last_operation_of_machine

        last_operation_of_product = schedule.operations_of_product(gene.product.id).last
        start_at = last_operation_of_product.end_at if last_operation_of_product && last_operation_of_product.end_at > start_at

        #puts
        #p last_operation_of_machine
        #p last_operation_of_product

        schedule.operations.build :product => gene.product, :machine => machine, :start_at => start_at,
          :end_at => start_at + gene.product.operation_times.of_machine(machine.id).time

        puts
        schedule.operations.each {|r| puts "produto: #{r.product.id} \t maquina: #{r.machine.id} \t\t #{r.start_at}-#{r.end_at}" }
        puts
      end
    end
    schedule
  end

end

