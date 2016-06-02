class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  before_save :ensure_auth_token

  enum sex: %i[male female]

  rails_admin do
    edit do
      fields :email, :password, :roles, :name, :city, :age, :sex
    end
    show do
      fields :email, :roles, :name, :city, :age, :sex
    end
    list do
      fields :id, :email, :name, :created_at
    end
  end

  def ensure_auth_token
    self.auth_token ||= generate_auth_token
  end

  private
  def generate_auth_token
    loop do
      token = Devise.friendly_token
      break token if User.where(auth_token: token).empty?
    end
  end
end
