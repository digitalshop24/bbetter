class Promocode < ActiveRecord::Base
  belongs_to :user
  belongs_to :referrer, class_name: 'User'
  scope :not_activated, ->{ where activated_at: nil }
  scope :available, ->{ not_activated.where referrer: nil }

  validates :code, presence: true, uniqueness: true, format: /[\d]{7}[a-z]{1}/

  rails_admin do
    object_label_method do
      :code
    end
  end
end
