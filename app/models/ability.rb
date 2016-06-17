class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new # guest user (not logged in)
    if user.role == 'admin'
      can :manage, :all
    else
      can :read, [:Post, :Comment]
      can :manage, :Comment do |comment|
      	comment.user == user
      end
    end

  end
end
