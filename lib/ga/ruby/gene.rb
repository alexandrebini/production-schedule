class Gene
  attr_reader :product, :roadmap

  def initialize(args={})
    raise ArgumentError.new("product is nil") if args[:product].nil?
    raise ArgumentError.new("roadmap is nil") if args[:roadmap].nil?
    @product = args[:product]
    @roadmap = args[:roadmap]
  end

  def to_a
    [@product.id, @roadmap.id]
  end

  # Gene Class
  def swap_roadmap!(roadmap=nil)
    return @roadmap = roadmap unless roadmap.nil?

    roadmap ||= @roadmap
    while @product.roadmaps.size > 1 && roadmap == @roadmap
      roadmap = @product.roadmaps.shuffle.first
    end
    @roadmap = roadmap
  end

  def clone
    Gene.new(:product => @product, :roadmap => @roadmap)
  end

end

