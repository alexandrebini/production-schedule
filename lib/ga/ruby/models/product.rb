class GARuby
  module Models
    class Product < Product

      def to_gene
        Gene.new(:product => self, :roadmap => roadmaps.shuffle.first)
      end

    end
  end
end

