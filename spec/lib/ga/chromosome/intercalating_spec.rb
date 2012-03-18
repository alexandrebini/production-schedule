require 'spec_helper'

describe Chromosome do
  context 'intercalary in the right order' do
    before(:each) do
      @m1 = Fabricate(:machine)
      @m2 = Fabricate(:machine)
      @m3 = Fabricate(:machine)

      @p1 = Fabricate :product, :operation_times => [], :roadmaps => [Fabricate(:roadmap, :machines => [@m1, @m2, @m3])]
      @p2 = Fabricate :product, :operation_times => [], :roadmaps => [Fabricate(:roadmap, :machines => [@m2, @m1, @m3])]
    end

    it 'for linear times' do
      chromosome = Chromosome.new :products => [@p1, @p2]

      Fabricate :operation_time, :product => @p1, :machine => @m1, :time => 100
      Fabricate :operation_time, :product => @p1, :machine => @m2, :time => 100
      Fabricate :operation_time, :product => @p1, :machine => @m3, :time => 100

      Fabricate :operation_time, :product => @p2, :machine => @m2, :time => 100
      Fabricate :operation_time, :product => @p2, :machine => @m1, :time => 100
      Fabricate :operation_time, :product => @p2, :machine => @m3, :time => 100

      chromosome.schedule[0].should == { :product_id => @p1.id, :machine_id => @m1.id, :start_at => 0,   :end_at => 100 }
      chromosome.schedule[1].should == { :product_id => @p2.id, :machine_id => @m2.id, :start_at => 0,   :end_at => 100 }
      chromosome.schedule[2].should == { :product_id => @p1.id, :machine_id => @m2.id, :start_at => 100, :end_at => 200 }
      chromosome.schedule[3].should == { :product_id => @p2.id, :machine_id => @m1.id, :start_at => 100, :end_at => 200 }
      chromosome.schedule[4].should == { :product_id => @p1.id, :machine_id => @m3.id, :start_at => 200, :end_at => 300 }
      chromosome.schedule[5].should == { :product_id => @p2.id, :machine_id => @m3.id, :start_at => 300, :end_at => 400 }
    end

    it 'for intermediate times' do
      chromosome = Chromosome.new :products => [@p2, @p1]

      Fabricate :operation_time, :product => @p1, :machine => @m1, :time => 150
      Fabricate :operation_time, :product => @p1, :machine => @m2, :time => 150
      Fabricate :operation_time, :product => @p1, :machine => @m3, :time => 100

      Fabricate :operation_time, :product => @p2, :machine => @m1, :time => 100
      Fabricate :operation_time, :product => @p2, :machine => @m2, :time => 50
      Fabricate :operation_time, :product => @p2, :machine => @m3, :time => 100

      chromosome.schedule[0].should == { :product_id => @p2.id, :machine_id => @m2.id, :start_at => 0,   :end_at => 50 }
      chromosome.schedule[1].should == { :product_id => @p1.id, :machine_id => @m1.id, :start_at => 0,   :end_at => 150 }
      chromosome.schedule[2].should == { :product_id => @p2.id, :machine_id => @m1.id, :start_at => 150, :end_at => 250 }
      chromosome.schedule[3].should == { :product_id => @p1.id, :machine_id => @m2.id, :start_at => 150, :end_at => 300 }
      chromosome.schedule[4].should == { :product_id => @p2.id, :machine_id => @m3.id, :start_at => 250, :end_at => 350 }
      chromosome.schedule[5].should == { :product_id => @p1.id, :machine_id => @m3.id, :start_at => 350, :end_at => 450 }
    end
  end
  
end