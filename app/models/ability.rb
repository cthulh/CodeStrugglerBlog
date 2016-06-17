class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
    else
      can :read, :all
      can :manage, Comment do |comment|
      	comment.user_id == user_id
      end
    end

  end
end
