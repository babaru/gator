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
    can :manage, Staff
  end

  def manager
    can :manage, Staff
  end

  def asset_manager
    can :manage_asset_management_info, Product
  end

  def customer_service
    can :manage_customer_service_info, Product
  end

  def staff
    can :read, Product
    can :manage, Department
    can :manage, Consultant
    can :manage, Client
    can :update, Staff, :id => @user.staff.id

    default_user
  end

  def default_user
    can :read, :all
  end
end
