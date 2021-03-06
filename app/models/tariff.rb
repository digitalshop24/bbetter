class Tariff < ActiveRecord::Base
  has_many :user_tariffs, dependent: :nullify
  has_many :users, through: :user_tariffs

  has_attached_file :image, styles: { medium: "700x700>", thumb: "200x200>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  has_attached_file :additional_image, styles: { medium: "700x700>", thumb: "200x200>" }
  validates_attachment_content_type :additional_image, content_type: /\Aimage\/.*\Z/

  rails_admin do    
    edit do
      exclude_fields :user_tariffs, :users
    end
    show do
      exclude_fields :user_tariffs, :users
    end
    list do
      exclude_fields :user_tariffs, :users
    end
  end
end
