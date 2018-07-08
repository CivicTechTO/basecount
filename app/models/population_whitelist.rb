class PopulationWhitelist < ApplicationRecord
  belongs_to :site
  enum code: [
    :women,
    :men,
    :children,
    :youth,
    :trans
  ]
end
