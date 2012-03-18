class Gene
  require "#{Rails.root}/lib/ga/transport"
  
  attr_reader :product, :roadmap, :transport

  def initialize(args={})
    raise ArgumentError.new('product is nil') if args[:product].nil?
    raise ArgumentError.new('roadmap is nil') if args[:roadmap].nil?
    @product = args[:product]
    @roadmap = args[:roadmap]
    unless args[:schema].nil?
      @transport = Transport.new(:roadmap => @roadmap, :schema => args[:schema])
    end
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

  def == gene
    if @transport
      self.product == gene.product && self.roadmap == gene.roadmap && self.transport == gene.transport
    else
      self.product == gene.product && self.roadmap == gene.roadmap
    end
  end
end