module Refinery
  module Themes
    class Theme < Refinery::Core::BaseModel
      #self.table_name = 'refinery_themes'

      #attr_accessible :name, :description, :position
      attr_accessor  :name, :description, :position
      #acts_as_indexed :fields => [:name, :description]

      #validates :name, :presence => true, :uniqueness => true

    end
  end
end
