require 'spec_helper'

describe GA do

  context 'dynamically adjusts rates' do
    before(:each) do
      @ga = GA.new(:crossover_rate => 75, :mutation_rate => 5)
    end

    context 'when fitnesse differente increases 10%' do
      before(:each) do
        @ga.adjust_rates!(10, 9)
      end
      it 'increase 5% cross rate until 100%' do
        @ga.crossover_rate.should == 80
        10.times{ @ga.adjust_rates!(10, 9) }
        @ga.crossover_rate.should == 100
      end
      it 'increase 0.5% mutation rate until 10%' do
        @ga.mutation_rate.should == 5.5
        10.times{ @ga.adjust_rates!(10, 9) }
        @ga.mutation_rate.should == 10
      end
    end

    context 'when fitnesse differente decreases 10%' do
      before(:each) do
        @ga.adjust_rates!(10, 11)
      end
      it 'decreases 5% cross rate until 50%' do
        @ga.crossover_rate.should == 70
        10.times{ @ga.adjust_rates!(10, 11) }
        @ga.crossover_rate.should == 50
      end
      it 'decreases 0.5% mutation rate until 0%' do
        @ga.mutation_rate.should == 4.5
        10.times{ @ga.adjust_rates!(10, 11) }
        @ga.mutation_rate.should == 0
      end
    end
  end

end