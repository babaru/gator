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
  end

  def product_manager
    can :manage, Product
  end

  def client_manager
    can :manage, Client
  end

  def default_user
  end
end
