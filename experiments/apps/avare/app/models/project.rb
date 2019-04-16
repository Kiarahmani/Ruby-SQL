class Project < ActiveRecord::Base
  validates :code, :presence => true, :length => { :minimum => 1, :maximum => 20 }, :uniqueness => true
  validates :name, :presence => true, :length => { :minimum => 1, :maximum => 100 }, :uniqueness => true
  validates :description, :presence => true, :length => { :minimum => 1, :maximum => 255 }
end
