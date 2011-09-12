class Cache
  class OperationTime < Array
    def of_machine(machine_id)
      self.find_all{ |r| r.product_id == product_id }
    end

    def of_product(product_id)
      self.find_all{ |r| r.product_id == product_id }
    end

    def of_product_and_machine(product_id, machine_id)
      cached = self.find{ |r| r.product_id == product_id && r.machine_id == machine_id }
      return cached if cached

      operation_time = Product.find(product_id).operation_times.of_machine(machine_id)
      cache! operation_time
      operation_time
    end

    def cache(args)
      if args.is_a?(Array)
        args.each{ |r| cache! r }
      else
        cache! args
      end
    end

    def cache!(operation_time)
      return if exists?(operation_time)
      self << operation_time
    end

    def exists?(args)
      if args.is_a?(OperationTime)
        self.include?(args)
      else
        self.find{ |r| r.id == args }
      end
    end
  end



  attr_reader :products, :operation_times

  def initialize
    @products = []
    @operation_times = Cache::OperationTime.new
  end

  def add_products(products)
    products.each do |product|
      #next if find_product(product)
      #@products << product
      @operation_times.cache product.operation_times
    end
  end

end

