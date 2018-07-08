class PopulationWhitelist < ApplicationRecord
  belongs_to :shelter
  enum code: [
    :women,
    :men,
    :children,
    :youth,
    :trans
  ]
end
