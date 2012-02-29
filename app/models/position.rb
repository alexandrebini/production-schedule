class Position < ActiveRecord::Base
  # associations
  belongs_to :schema
  belongs_to :machine
end