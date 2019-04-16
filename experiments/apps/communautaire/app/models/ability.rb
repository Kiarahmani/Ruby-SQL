class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new #guest
    if user.administrator?# == true
      can :manage, :all
    else
      can :read, :all
      can :create, Topic
      can :update, Topic, :author => user.id # do |topic|
        # topic.user == user# || user.administrator?(true)
      # end
    end
  end

end
