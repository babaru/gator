class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  # before_save :set_product_manager_name

  attr_accessor :login

  has_many :assignments
  has_many :roles, through: :assignments
  has_one :staff

  validates :username,
   :presence => true,
   :uniqueness => {
     :case_sensitive => false
   }

  validate :validate_username

  validates :email, presence: true

  accepts_nested_attributes_for :staff

  def name
    if staff
      staff.name
    else
      "#{username} (#{email})"
    end
  end

  def validate_username
   if User.where(email: username).exists?
     errors.add(:username, :invalid)
   end
  end

  def self.find_for_database_authentication(warden_conditions)
   conditions = warden_conditions.dup
   if login = conditions.delete(:login)
     where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
   elsif conditions.has_key?(:username) || conditions.has_key?(:email)
     conditions[:email].downcase! if conditions[:email]
     where(conditions.to_h).first
   end
  end

  def has_role?(role_sym)
    roles.any? { |r| r.name.to_sym == role_sym }
  end

  private

  def set_product_manager_name
    self.product_manager.name = self.name if product_manager
  end
end
