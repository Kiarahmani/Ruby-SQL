# Ability documentation
#
# The ability class defines the user types and permission within your application. E.g. admin, user and guest.
class Ability
    include CanCan::Ability

    def initialize(user)
      user ||= User.new
      if user.admin?
        can :manage, :all
      else 
        can :read, Product
        can :read, Category
        can :manage, User
        can [:show, :create, :destroy], [Cart]
        can [:create, :destroy], [CartItem]
      end
    end

    def guest_permissions(user)
    end

    def user_permissions(user)
        guest_permissions(user)
    end

    def admin_permissions(user)
        user_permissions(user)
        can :manage, :all
    end

end
