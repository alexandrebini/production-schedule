require 'spec_helper'

describe GA do

  it 'problem 1: best makespan should be between Morandin (2198) and Sanches (2354)' do
    m1, m2, m3, m4, m5, m6 = Array.new(9){ Fabricate(:machine) }
    p1 = Fabricate(:product,
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

    p2 = Fabricate(:product,
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

    p3 = Fabricate(:product,
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
    ga = GA.new(
      :products => [p1, p2, p3], 
      :length => 30, 
      :max_generations => 100, 
      :mutation_date => 5, 
      :crossover_rate => 60
    )
    ga.run
    (2_100..2_400).should cover(ga.population.best.fitness)
  end
  
end