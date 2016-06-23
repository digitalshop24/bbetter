class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  has_many :user_tariffs, dependent: :destroy
  has_many :videos, dependent: :destroy
  has_many :tariffs, through: :user_tariffs
  has_many :galleries, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :images, through: :galleries
  has_many :summaries, dependent: :destroy
  has_one :promocode

  before_save :ensure_auth_token

  enum sex: %i[male female]

  def active_tariff
    user_tariffs.active.last.tariff if user_tariffs.active.last
  end

  def display_name
    email
  end

  rails_admin do
    object_label_method do
      :display_name
    end
    
    edit do
      fields :email, :password, :roles, :name, :city, :age, :sex, :promocode
    end
    show do
      fields :email, :roles, :name, :city, :age, :sex, :promocode
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
