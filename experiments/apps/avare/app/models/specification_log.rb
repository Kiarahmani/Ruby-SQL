class SpecificationLog < ActiveRecord::Base
  belongs_to :specification
  belongs_to :category
  belongs_to :project
  belongs_to :contractor, :class_name => "User"
  belongs_to :controller, :class_name => "User"  
end
