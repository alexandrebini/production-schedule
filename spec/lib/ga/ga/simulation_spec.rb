require 'spec_helper'

describe GA do

  context 'simulation' do
    before(:each) do
      @m1 = Fabricate(:machine)
      @m2 = Fabricate(:machine)
      @m3 = Fabricate(:machine)

      @p1 = Fabricate :product, :operation_times => [], :roadmaps => [Fabricate(:roadmap, :machines => [@m1, @m2, @m3])]
      @p2 = Fabricate :product, :operation_times => [], :roadmaps => [Fabricate(:roadmap, :machines => [@m2, @m1, @m3])]
    end

    it 'for linear times' do
      Fabricate :operation_time, :product => @p1, :machine => @m1, :time => 100
      Fabricate :operation_time, :product => @p1, :machine => @m2, :time => 100
      Fabricate :operation_time, :product => @p1, :machine => @m3, :time => 100

      Fabricate :operation_time, :product => @p2, :machine => @m2, :time => 100
      Fabricate :operation_time, :product => @p2, :machine => @m1, :time => 100
      Fabricate :operation_time, :product => @p2, :machine => @m3, :time => 100

      ga = GA.new(:products => [@p1, @p2], :length => 10, :max_generations => 10)
      ga.run
      ga.population.best.fitness.should == 400
    end

    it 'for intermediate times' do
      Fabricate :operation_time, :product => @p1, :machine => @m1, :time => 150
      Fabricate :operation_time, :product => @p1, :machine => @m2, :time => 150
      Fabricate :operation_time, :product => @p1, :machine => @m3, :time => 100

      Fabricate :operation_time, :product => @p2, :machine => @m1, :time => 100
      Fabricate :operation_time, :product => @p2, :machine => @m2, :time => 50
      Fabricate :operation_time, :product => @p2, :machine => @m3, :time => 100

      ga = GA.new(:products => [@p1, @p2], :length => 10, :max_generations => 10)
      ga.run
      ga.population.best.fitness.should == 500
    end
  end

end