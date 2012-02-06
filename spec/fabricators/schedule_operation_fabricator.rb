Fabricator(:schedule_operation) do
  schedule
  product
  machine

  start_at { rand(999) }
  end_at { rand(999) + 999 }
end