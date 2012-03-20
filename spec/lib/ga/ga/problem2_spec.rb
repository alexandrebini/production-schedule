require 'spec_helper'

describe GA do

  it 'problem 2: best makespan should be between the min and max of Morandin (4.673 to 5.518)' do
    m1, m2, m3, m4, m5, m6, m7, m8, m9 = Array.new(9){ Fabricate(:machine) }

    p1_operations = [ [m1,428], [m2,423], [m3,459], [m4,433], [m5,467], [m6,461], [m7,464], [m8,455], [m9,418] ]
    p1_roadmaps = [ [m1,m2,m4,m5,m7,m9], [m3,m4,m5,m6,m8,m9] ]
    p1 = Fabricate(:product) do
      operation_times!(:count => p1_operations.size) do |parent, i| 
        Fabricate :operation_time, :product => parent, :machine => p1_operations[i-1].first, :time => p1_operations[i-1].last
      end
      roadmaps!(:count => p1_roadmaps.count) do |parent, i| 
        Fabricate :roadmap, :product => parent, :machines => p1_roadmaps[i-1]
      end
    end
    
    p2_operations = [ [m1,439], [m2,433], [m3,487], [m4,405], [m5,447], [m6,497], [m7,495], [m8,469], [m9,439] ]
    p2_roadmaps = [ [m1,m2,m3,m4,m5,m6,m7], [m2,m3,m5,m7,m8,m9] ]
    p2 = Fabricate(:product) do
      operation_times!(:count => p2_operations.size) do |parent, i| 
        Fabricate :operation_time, :product => parent, :machine => p2_operations[i-1].first, :time => p2_operations[i-1].last
      end
      roadmaps!(:count => p2_roadmaps.count) do |parent, i| 
        Fabricate :roadmap, :product => parent, :machines => p2_roadmaps[i-1]
      end
    end
    
    p3_operations = [ [m1,453], [m2,474], [m3,417], [m4,447], [m5,486], [m6,496], [m7,459], [m8,489], [m9,480] ]
    p3_roadmaps = [ [m4,m5,m6,m7,m8], [m2,m3,m7,m8,m9] ]
    p3 = Fabricate(:product) do
      operation_times!(:count => p3_operations.size) do |parent, i| 
        Fabricate :operation_time, :product => parent, :machine => p3_operations[i-1].first, :time => p3_operations[i-1].last
      end
      roadmaps!(:count => p3_roadmaps.count) do |parent, i| 
        Fabricate :roadmap, :product => parent, :machines => p3_roadmaps[i-1]
      end
    end
    
    p4_operations = [ [m1,403], [m2,436], [m3,410], [m4,410], [m5,400], [m6,468], [m7,489], [m8,439], [m9,457] ]
    p4_roadmaps = [ [m2,m3,m4,m6,m7], [m1,m5,m6,m8,m9] ]
    p4 = Fabricate(:product) do
      operation_times!(:count => p4_operations.size) do |parent, i| 
        Fabricate :operation_time, :product => parent, :machine => p4_operations[i-1].first, :time => p4_operations[i-1].last
      end
      roadmaps!(:count => p4_roadmaps.count) do |parent, i| 
        Fabricate :roadmap, :product => parent, :machines => p4_roadmaps[i-1]
      end
    end
        
    p5_operations = [ [m1,481], [m2,440], [m3,477], [m4,442], [m5,450], [m6,468], [m7,436], [m8,486], [m9,435] ]
    p5_roadmaps = [ [m4,m5,m7,m8,m9], [m1,m2,m3,m5,m6] ]
    p5 = Fabricate(:product) do
      operation_times!(:count => p5_operations.size) do |parent, i| 
        Fabricate :operation_time, :product => parent, :machine => p5_operations[i-1].first, :time => p5_operations[i-1].last
      end
      roadmaps!(:count => p5_roadmaps.count) do |parent, i| 
        Fabricate :roadmap, :product => parent, :machines => p5_roadmaps[i-1]
      end
    end
    
    p6_operations = [ [m1,446], [m2,495], [m3,474], [m4,448], [m5,469], [m6,408], [m7,454], [m8,424], [m9,482] ]
    p6_roadmaps = [ [m2,m4,m5,m6,m7,m8,m9], [m1,m3,m6,m7,m8,m9] ]
    p6 = Fabricate(:product) do
      operation_times!(:count => p6_operations.size) do |parent, i| 
        Fabricate :operation_time, :product => parent, :machine => p6_operations[i-1].first, :time => p6_operations[i-1].last
      end
      roadmaps!(:count => p6_roadmaps.count) do |parent, i| 
        Fabricate :roadmap, :product => parent, :machines => p6_roadmaps[i-1]
      end
    end
    
    p7_operations = [ [m1,414], [m2,457], [m3,452], [m4,426], [m5,493], [m6,408], [m7,457], [m8,497], [m9,445] ]
    p7_roadmaps = [ [m1,m2,m4,m5,m6,m9], [m1,m2,m3,m7,m8,m9] ]
    p7 = Fabricate(:product) do
      operation_times!(:count => p7_operations.size) do |parent, i| 
        Fabricate :operation_time, :product => parent, :machine => p7_operations[i-1].first, :time => p7_operations[i-1].last
      end
      roadmaps!(:count => p7_roadmaps.count) do |parent, i| 
        Fabricate :roadmap, :product => parent, :machines => p7_roadmaps[i-1]
      end
    end
        
    p8_operations = [ [m1,491], [m2,419], [m3,435], [m4,491], [m5,495], [m6,452], [m7,477], [m8,452], [m9,408] ]
    p8_roadmaps = [ [m4,m5,m6,m7,m8,m9], [m3,m4,m5,m7,m8,m9] ]
    p8 = Fabricate(:product) do
      operation_times!(:count => p8_operations.size) do |parent, i| 
        Fabricate :operation_time, :product => parent, :machine => p8_operations[i-1].first, :time => p8_operations[i-1].last
      end
      roadmaps!(:count => p8_roadmaps.count) do |parent, i| 
        Fabricate :roadmap, :product => parent, :machines => p8_roadmaps[i-1]
      end
    end
        
    p9_operations = [ [m1,458], [m2,486], [m3,416], [m4,454], [m5,452], [m6,438], [m7,484], [m8,435], [m9,416] ]
    p9_roadmaps = [ [m3,m5,m6,m7,m8,m9], [m2,m4,m6,m7,m8,m9] ]
    p9 = Fabricate(:product) do
      operation_times!(:count => p9_operations.size) do |parent, i| 
        Fabricate :operation_time, :product => parent, :machine => p9_operations[i-1].first, :time => p9_operations[i-1].last
      end
      roadmaps!(:count => p9_roadmaps.count) do |parent, i| 
        Fabricate :roadmap, :product => parent, :machines => p9_roadmaps[i-1]
      end
    end


    ga = GA.new(
      :products => [p1, p2, p3, p4, p5, p6, p7, p8, p9],
      :length => 40,
      :max_generations => 100,
      :mutation_rate => 40,
      :crossover_rate => 80
    )

    ga.run
    (4_673..5_518).should cover(ga.population.best.fitness)
  end
  
end