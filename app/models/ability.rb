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
  end

  def product_manager
    can :manage, Product, :product_manager_id => user.id
    can :read, Product
  end

  def default_user
  end
end
