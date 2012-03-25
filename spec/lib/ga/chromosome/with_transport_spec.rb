require 'spec_helper'

describe Chromosome do
  context 'with 2 positions transport' do
    # A ----- B
    before(:each) do
      @schema = Fabricate(:schema)
      @machine_a = Fabricate(:machine)
      @machine_b = Fabricate(:machine)
      @position_a = Fabricate(:position, :schema => @schema, :machine => @machine_a)
      @position_b = Fabricate(:position, :schema => @schema, :machine => @machine_b)
      @path_ab = Fabricate(:segment, :origin => @position_a, :target => @position_b, :distance => 1_000)
      @vehicle = Fabricate(:vehicle, :speed => 1.5) # 60m/min
    end
    
    it 'simple route: p1(ma-mb) p2(mb-ma)' do
      product_1 = Fabricate(:product,
        :operation_times => [
          Fabricate(:operation_time, :machine => @machine_a, :time => 100),
          Fabricate(:operation_time, :machine => @machine_b, :time => 100)
        ],
        :roadmaps => [
          Fabricate(:roadmap, :machines => [@machine_a, @machine_b])
        ]
      )
    
      product_2 = Fabricate(:product,
        :operation_times => [
          Fabricate(:operation_time, :machine => @machine_a, :time => 100),
          Fabricate(:operation_time, :machine => @machine_b, :time => 100)
        ],
        :roadmaps => [
          Fabricate(:roadmap, :machines => [@machine_b, @machine_a])
        ]
      )
    
      chromosome = Chromosome.new(:products => [product_1, product_2], :schema => @schema, :vehicles => [@vehicle])
    
      chromosome.schedule[0].should == { 
        :start_at => 0, :end_at => 100, :product_id => product_1.id, :machine_id => @machine_a.id
      }
      
      chromosome.schedule[1].should == { 
        :start_at => 0, :end_at => 100, :product_id => product_2.id, :machine_id => @machine_b.id
      }
      
      chromosome.schedule[2].should == { 
        :start_at => 100, :end_at => 160, :product_id => product_1.id, :vehicle_id => @vehicle.id,
        :start_position_id => @position_a.id, :goal_position_id => @position_b.id
      }
      
      chromosome.schedule[3].should == { 
        :start_at => 160, :end_at => 260, :product_id => product_1.id, :machine_id => @machine_b.id
      }
      
      chromosome.schedule[4].should == { 
        :start_at => 160, :end_at => 220, :product_id => product_2.id, :vehicle_id => @vehicle.id,
        :start_position_id => @position_b.id, :goal_position_id => @position_a.id
      }
      
      chromosome.schedule[5].should == { 
        :start_at => 220, :end_at => 320, :product_id => product_2.id, :machine_id => @machine_a.id
      }
    end
    
    it 'same route: p1(ma-mb) p2(ma-mb)' do
      puts "\n\n\n\n\n #teste 2"
      product_1 = Fabricate(:product,
        :operation_times => [
          Fabricate(:operation_time, :machine => @machine_a, :time => 100),
          Fabricate(:operation_time, :machine => @machine_b, :time => 100)
        ],
        :roadmaps => [
          Fabricate(:roadmap, :machines => [@machine_a, @machine_b])
        ]
      )
    
      product_2 = Fabricate(:product,
        :operation_times => [
          Fabricate(:operation_time, :machine => @machine_a, :time => 100),
          Fabricate(:operation_time, :machine => @machine_b, :time => 100)
        ],
        :roadmaps => [
          Fabricate(:roadmap, :machines => [@machine_a, @machine_b])
        ]
      )
    
      chromosome = Chromosome.new(:products => [product_1, product_2], :schema => @schema, :vehicles => [@vehicle])
    
      chromosome.schedule[0].should == { 
        :start_at => 0, :end_at => 100, :product_id => product_1.id, :machine_id => @machine_a.id
      }
      
      chromosome.schedule[1].should == { 
        :start_at => 100, :end_at => 200, :product_id => product_2.id, :machine_id => @machine_a.id
      }
      #       
      #       chromosome.schedule[2].should == { 
      #         :start_at => 100, :end_at => 160, :product_id => product_1.id, :vehicle_id => @vehicle.id,
      #         :start_position_id => @position_a.id, :goal_position_id => @position_b.id
      #       }
      #       
      #       chromosome.schedule[3].should == { 
      #         :start_at => 160, :end_at => 260, :product_id => product_1.id, :machine_id => @machine_b.id
      #       }
      #       
      #       chromosome.schedule[4].should == { 
      #         :start_at => 160, :end_at => 220, :product_id => product_2.id, :vehicle_id => @vehicle.id,
      #         :start_position_id => @position_b.id, :goal_position_id => @position_a.id
      #       }
      #       
      #       chromosome.schedule[5].should == { 
      #         :start_at => 200, :end_at => 280, :product_id => product_2.id, :vehicle_id => @vehicle.id,
      #         :start_position_id => @position_a.id, :goal_position_id => @position_b.id
      #       }
      #       
      #       chromosome.schedule[6].should == { 
      #         :start_at => 280, :end_at => 380, :product_id => product_2.id, :machine_id => @machine_b.id
      #       }
    end

  end
end