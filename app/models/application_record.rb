class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class 
end

# in lecture it was like this: self.abstract_class = true