require "spec_helper"

describe GA do

  it 'problem 1' do
    m1, m2, m3, m4, m5, m6 = Array.new(9){ Machine.make! }
    p1 = Product.make!(
      :operation_times  => [
        OperationTime.new(:machine => m1, :time => 434),
        OperationTime.new(:machine => m2, :time => 452),
        OperationTime.new(:machine => m3, :time => 400),
        OperationTime.new(:machine => m4, :time => 472),
        OperationTime.new(:machine => m5, :time => 460),
        OperationTime.new(:machine => m6, :time => 421)
      ],
      :roadmaps => [
        Roadmap.new(:machines => [m1, m2, m3, m4, m5]),
        Roadmap.new(:machines => [m1, m2, m3, m6])
      ]
    )

    p2 = Product.make!(
      :operation_times  => [
        OperationTime.new(:machine => m1, :time => 458),
        OperationTime.new(:machine => m2, :time => 443),
        OperationTime.new(:machine => m3, :time => 405),
        OperationTime.new(:machine => m4, :time => 485),
        OperationTime.new(:machine => m5, :time => 402),
        OperationTime.new(:machine => m6, :time => 435)
      ],
      :roadmaps => [
        Roadmap.new(:machines => [m1, m4, m5, m6]),
        Roadmap.new(:machines => [m2, m4, m5, m6]),
        Roadmap.new(:machines => [m3, m4, m5, m6]),
      ]
    )

    p3 = Product.make!(
      :operation_times  => [
        OperationTime.new(:machine => m1, :time => 472),
        OperationTime.new(:machine => m2, :time => 465),
        OperationTime.new(:machine => m3, :time => 469),
        OperationTime.new(:machine => m4, :time => 459),
        OperationTime.new(:machine => m5, :time => 432),
        OperationTime.new(:machine => m6, :time => 444)
      ],
      :roadmaps => [
        Roadmap.new(:machines => [m1, m5, m6]),
        Roadmap.new(:machines => [m2, m5, m6]),
        Roadmap.new(:machines => [m3, m4, m5, m6]),
      ]
    )
    #ga = GA.new(:products => [p1, p2, p3], :length => 30, :max_generations => 100, :mutation_date => 5, :crossover_rate => 60)
    #p ga
    #ga.run
    #p ga.population.best
    #p ga.population.fitness
  end
=begin
  it 'problem 2' do
    m1, m2, m3, m4, m5, m6, m7, m8, m9 = Array.new(9){ Machine.make! }

    p1_operations = [ [m1,428], [m2,423], [m3,459], [m4,433], [m5,467], [m6,461], [m7,464], [m8,455], [m9,418] ]
    p1_roadmaps = [ [m1,m2,m4,m5,m7,m9], [m3,m4,m5,m6,m8,m9] ]
    p1 = Product.make!(
      :operation_times => p1_operations.map{|machine, time| OperationTime.make(:machine => machine, :time => time) },
      :roadmaps => p1_roadmaps.map{|machines| Roadmap.make(:machines => machines)}
    )

    p2_operations = [ [m1,439], [m2,433], [m3,487], [m4,405], [m5,447], [m6,497], [m7,495], [m8,469], [m9,439] ]
    p2_roadmaps = [ [m1,m2,m3,m4,m5,m6,m7], [m2,m3,m5,m7,m8,m7] ]
    p2 = Product.make!(
      :operation_times => p2_operations.map{|machine, time| OperationTime.make(:machine => machine, :time => time) },
      :roadmaps => p2_roadmaps.map{|machines| Roadmap.make(:machines => machines)}
    )

    p3_operations = [ [m1,453], [m2,474], [m3,417], [m4,447], [m5,486], [m6,496], [m7,459], [m8,489], [m9,480] ]
    p3_roadmaps = [ [m4,m5,m6,m7,m8], [m2,m3,m7,m8,m9] ]
    p3 = Product.make!(
      :operation_times => p3_operations.map{|machine, time| OperationTime.make(:machine => machine, :time => time) },
      :roadmaps => p3_roadmaps.map{|machines| Roadmap.make(:machines => machines)}
    )

    p4_operations = [ [m1,403], [m2,436], [m3,410], [m4,410], [m5,400], [m6,468], [m7,489], [m8,439], [m9,457] ]
    p4_roadmaps = [ [m2,m3,m4,m6,m7], [m1,m5,m6,m8,m9] ]
    p4 = Product.make!(
      :operation_times => p4_operations.map{|machine, time| OperationTime.make(:machine => machine, :time => time) },
      :roadmaps => p4_roadmaps.map{|machines| Roadmap.make(:machines => machines)}
    )

    p5_operations = [ [m1,481], [m2,440], [m3,477], [m4,442], [m5,450], [m6,468], [m7,436], [m8,486], [m9,435] ]
    p5_roadmaps = [ [m4,m5,m7,m8,m9], [m1,m2,m3,m5,m6] ]
    p5 = Product.make!(
      :operation_times => p5_operations.map{|machine, time| OperationTime.make(:machine => machine, :time => time) },
      :roadmaps => p5_roadmaps.map{|machines| Roadmap.make(:machines => machines)}
    )

    p6_operations = [ [m1,446], [m2,495], [m3,474], [m4,448], [m5,469], [m6,408], [m7,454], [m8,424], [m9,482] ]
    p6_roadmaps = [ [m2,m4,m5,m6,m7,m8,m9], [m1,m3,m6,m7,m8,m9] ]
    p6 = Product.make!(
      :operation_times => p6_operations.map{|machine, time| OperationTime.make(:machine => machine, :time => time) },
      :roadmaps => p6_roadmaps.map{|machines| Roadmap.make(:machines => machines)}
    )

    p7_operations = [ [m1,414], [m2,457], [m3,452], [m4,426], [m5,493], [m6,408], [m7,457], [m8,497], [m9,445] ]
    p7_roadmaps = [ [m1,m2,m4,m5,m6,m9], [m1,m2,m3,m7,m8,m9] ]
    p7 = Product.make!(
      :operation_times => p7_operations.map{|machine, time| OperationTime.make(:machine => machine, :time => time) },
      :roadmaps => p7_roadmaps.map{|machines| Roadmap.make(:machines => machines)}
    )

    p8_operations = [ [m1,491], [m2,419], [m3,435], [m4,491], [m5,495], [m6,452], [m7,477], [m8,452], [m9,408] ]
    p8_roadmaps = [ [m4,m5,m6,m7,m8,m9], [m3,m4,m5,m7,m8,m9] ]
    p8 = Product.make!(
      :operation_times => p8_operations.map{|machine, time| OperationTime.make(:machine => machine, :time => time) },
      :roadmaps => p8_roadmaps.map{|machines| Roadmap.make(:machines => machines)}
    )

    p9_operations = [ [m1,458], [m2,486], [m3,416], [m4,454], [m5,452], [m6,438], [m7,484], [m8,435], [m9,416] ]
    p9_roadmaps = [ [m3,m5,m6,m7,m8,m9], [m2,m4,m6,m7,m8,m9] ]
    p9 = Product.make!(
      :operation_times => p9_operations.map{|machine, time| OperationTime.make(:machine => machine, :time => time) },
      :roadmaps => p9_roadmaps.map{|machines| Roadmap.make(:machines => machines)}
    )

    ga = GA.new(
      :products => [p1, p2, p3, p4, p5, p9, p7, p8, p9],
      :length => 40,
      :max_generations => 100,
      :mutation_date => 5,
      :crossover_rate => 80)
    #p ga
    #ga.run
    #p ga.best_chromosome
    #p ga.best_chromosome.fitness
  end
=end

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

  context 'simulating' do
    before(:each) do
      @m1 = Machine.make!
      @m2 = Machine.make!
      @m3 = Machine.make!

      @p1 = Product.make :operation_times => [], :roadmaps => [Roadmap.make(:machines => [@m1, @m2, @m3])]
      @p2 = Product.make :operation_times => [], :roadmaps => [Roadmap.make(:machines => [@m2, @m1, @m3])]
    end

    it 'for linear times' do
      OperationTime.make! :product => @p1, :machine => @m1, :time => 100
      OperationTime.make! :product => @p1, :machine => @m2, :time => 100
      OperationTime.make! :product => @p1, :machine => @m3, :time => 100

      OperationTime.make! :product => @p2, :machine => @m2, :time => 100
      OperationTime.make! :product => @p2, :machine => @m1, :time => 100
      OperationTime.make! :product => @p2, :machine => @m3, :time => 100

      ga = GA.new(:products => [@p1, @p2], :length => 10, :max_generations => 10)
      ga.run
      ga.population.best.fitness.should == 400
    end

    it 'for intermediate times' do
      OperationTime.make! :product => @p1, :machine => @m1, :time => 150
      OperationTime.make! :product => @p1, :machine => @m2, :time => 150
      OperationTime.make! :product => @p1, :machine => @m3, :time => 100

      OperationTime.make! :product => @p2, :machine => @m1, :time => 100
      OperationTime.make! :product => @p2, :machine => @m2, :time => 50
      OperationTime.make! :product => @p2, :machine => @m3, :time => 100

      ga = GA.new(:products => [@p1, @p2], :length => 5, :max_generations => 1)
      ga.run
      ga.population.best.fitness.should == 450
    end
  end

end

