class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new # guest user (not logged in)
    if user.role=="admin"
      can :manage, :all
    elsif user.role=="moderator"
      can :read, [Comment, Post]
      can :update, Comment
    else
      can :read, User, id: user.id
      can :read, [Comment, Post]
      can [:create, :update, :destroy], Comment, id: user.id
    end

  end
end
