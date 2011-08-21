require "spec_helper"

describe GARuby::Population do
  it 'initializer auto create chromosomes' do
    population = GARuby::Population.new
    population.chromosomes.should_not be_nil
  end
end

