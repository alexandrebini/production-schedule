Fabricator(:product) do
  name { Faker::Lorem.words.first }

  operation_times!(:count => 3) do |parent, i| 
    Fabricate :operation_time, :product => parent
  end

  roadmaps!(:count => 2) do |parent, i| 
    Fabricate :roadmap, :product => parent, :machines => parent.operation_times.map(&:machine) 
  end
end