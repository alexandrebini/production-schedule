class GARuby::Gene
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

  def swap!(roadmap=nil)
    if roadmap.nil?
      if @product.roadmaps.size > 1
        roadmap = @product.roadmaps.shuffle.first while roadmap == @roadmap
      else
        roadmap = @product.roadmaps.shuffle.first
      end
    end
    @roadmap = roadmap
  end

end

