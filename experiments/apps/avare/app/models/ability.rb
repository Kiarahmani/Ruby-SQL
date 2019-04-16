class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.role? :admin
      can :manage, :all
    elsif user.role? :reader
      can :read, :all
    elsif user.role? :contractor
      can :manage, Upload
      can :study, Specification
      can :delete_studying, Specification
    elsif user.role? :controller
      can :manage, Project
      can :manage, Category
      can :approve, Specification
    end
    if user.role? :chief_contractor
      can :delete_archived, Specification
    elsif user.role? :chief_controller
      can :delete_archived, Specification
    end
  end
end
