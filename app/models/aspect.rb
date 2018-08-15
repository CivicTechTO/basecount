# Basically "tags" for a site, like wheelchair accessible
# Population-based tags are handled in PopulationWhitelists
class Aspect < ApplicationRecord
  has_and_belongs_to_many :sites
end
