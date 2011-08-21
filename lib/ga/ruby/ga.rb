module GARuby
  autoload :Chromosome, File.expand_path('../chromosome', __FILE__)
  autoload :Gene,       File.expand_path('../gene', __FILE__)
  autoload :Population, File.expand_path('../population', __FILE__)

  module Models
    autoload :Product, File.expand_path('../models/product', __FILE__)
  end
end

