class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :name
  validates_uniqueness_of :name, :email, :case_sensitive => false
  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  
  scope :with_role, lambda { |role| {:conditions => "roles_mask & #{2**ROLES.index(role.to_s)} > 0 "} }  
  ROLES = %w[admin reader contractor controller chief_contractor chief_controller]
  
  def roles=(roles)  
    logger.info self.roles_mask    
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum  
    logger.info self.roles_mask
  end  
  
  def roles  
    ROLES.reject { |r| ((roles_mask || 0) & 2**ROLES.index(r)).zero? }  
  end  
  
  def role?(role)  
    roles.include? role.to_s  
  end  
end
