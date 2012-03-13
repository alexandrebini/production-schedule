Fabricator(:schedule) do
  operations!(:count => 5){ |parent, i| Fabricate(:schedule_operation, :schedule => parent)  }
  training
  makespan { rand 99 }
end