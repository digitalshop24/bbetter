class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  rails_admin do
    edit do
      fields :email, :password, :roles
    end
    show do
      fields :email, :password, :roles
    end
    list do
      field :email
    end
  end
end
