class Promocode < ActiveRecord::Base
  belongs_to :user
  scope :available, ->{ where activated_at: nil }

  validates :code, presence: true, uniqueness: true, format: /[\d]{7}[a-z]{1}/

  rails_admin do
    object_label_method do
      :code
    end
  end
end
