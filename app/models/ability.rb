class Ability
  include CanCan::Ability

  def initialize(user)
    @user = user || User.new
    @user.roles.each { |role| send(role.name) }

    if @user.roles.size == 0
      default_user
    end
  end

  def admin
    can :manage, User
    can :manage, Department
    can :manage, Bank
    can :manage, SecuritiesBroker
    can :manage, Consultant
    can :manage, Staff

    default_user
  end

  def product_manager
    can :manage, Product
    can :manage, Department
    can :manage, Bank
    can :manage, SecuritiesBroker
    can :manage, Trustor
    can :manage, Consultant
    can :manage, Client
    can :update, Staff, :id => @user.id

    default_user
  end

  def client_manager
    can :manage, Client
  end

  def default_user
    can :read, :all
  end
end
