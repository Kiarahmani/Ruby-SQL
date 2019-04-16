#encoding: utf-8
class Specification < ActiveRecord::Base
  belongs_to :category
  belongs_to :project
  belongs_to :contractor, :class_name => "User"
  belongs_to :controller, :class_name => "User"
  has_many :specification_logs, :order => 'id DESC'
   
   
  validates :entity,            :presence => true, :length => { :minimum => 1, :maximum => 100 }
  validates :supplier,          :length => { :minimum => 0, :maximum => 100 }
  validates :unit,              :length => { :minimum => 0, :maximum => 10  }    
  validates :quantity,          :presence => true, :numericality => { :greather_then_or_equal => 0.0 } 
  validates :price_with_vat,    :presence => true, :numericality => { :greather_then_or_equal => 0.0 } 
  validates :coast_of_delivery, :presence => true, :numericality => { :greather_then_or_equal => 0.0 } 
  validates :notice,                  :length => { :minimum => 0, :maximum => 255 }  
  validates :recommended_conditions,  :length => { :minimum => 0, :maximum => 255 } 
  validates :recommended_supplier,    :length => { :minimum => 0, :maximum => 255 } 
  validates :recommended_notice,      :length => { :minimum => 0, :maximum => 255 } 
  validates_presence_of :category, :project, :contractor
  before_create :initialize_attributes
  after_save :log_specification
  
  def log_specification
    self.specification_logs.create :entity => self.entity,
      :unit => self.unit,
      :quantity => self.quantity,
      :price_with_vat => self.price_with_vat,
      :coast_of_delivery => self.coast_of_delivery,
      :category_id => self.category_id,
      :supplier => self.supplier,
      :project_id => self.project_id,
      :notice => self.notice,
      :recommended_conditions => self.recommended_conditions,      
      :recommended_supplier => self.recommended_supplier,          
      :recommended_notice => self.recommended_notice,       
      :contractor_id => self.contractor_id,         
      :controller_id => self.controller_id,          
      :state => self.state               
  end

  def initialize_attributes
    self.state_switched_at = Time.now
    self.studying_duration = 0
    self.approving_duration = 0
  end

  def state_switched_at_human
    self.state_switched_at.strftime("%d.%m.%y %H:%M")
  end
  
  def state_duration_human
    self.duration_to_human(Time.now - self.state_switched_at)
  end
  
  def studying_duration_human
    duration = 0
    if not self.studying_duration.nil? then
      duration += self.studying_duration
    end
    if self.studying? then 
      duration += (Time.now - self.state_switched_at)
    end
    self.duration_to_human(duration) << "-"    
  end
  
  def approving_duration_human
    duration = 0
    if not self.approving_duration.nil? then
      duration += self.approving_duration
    end
    if self.approving? then 
      duration += (Time.now - self.state_switched_at)
    end
    self.duration_to_human(duration) << "+"  
  end
  
  def total_duration_human
    duration = 0
    if not self.approving_duration.nil? then
      duration += self.approving_duration
    end
    if self.approving? then 
      duration += (Time.now - self.state_switched_at)
    end

    self.duration_to_human(duration)  
    
    
    self.duration_to_human(self.studying_duration+self.approving_duration)
  end
  
  def duration_to_human(secs)
    result = ""
    if secs > 0
      n, secs = secs.divmod(60*60*24)
      if n > 0 then 
        result += "#{n.to_i}д "
      end
    end
    
    if secs > 0
      n, secs = secs.divmod(60*60)
      result += "#{n.to_i}ч"
    end
    
    return result
  end
  
  # state_machine :state, :initial => :studying do
  #   
  #   before_transition :studying => :approving do |specification, transition|
  #     duration = Time.now - specification.state_switched_at
  #     specification.studying_duration += duration
  #   end

  #   before_transition :approving => [:studying, :archived] do |specification, transition|
  #     duration = Time.now - specification.state_switched_at
  #     specification.approving_duration += duration
  #   end
  #   
  #   event :approve do
  #     transition :studying => :approving
  #   end
  #   
  #   event :accept do
  #     transition :approving => :archived
  #   end
  #   
  #   event :decline do
  #     transition :approving => :studying
  #   end

  #   event :delete_studying do
  #     transition :studying => :deleted
  #   end

  #   event :delete_by_controller do
  #     transition :archived => :deleted_by_controller
  #   end

  #   event :delete_by_contractor do
  #     transition :archived => :deleted_by_contractor
  #   end

  #   event :delete_archived do
  #     transition :deleted_by_controller => :deleted, :deleted_by_contractor => :deleted
  #   end

  # end
end
