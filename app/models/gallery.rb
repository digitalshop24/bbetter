class Gallery < ActiveRecord::Base
  belongs_to :user
  has_many :images

  rails_admin do
    list do
      exclude_fields :images
    end
  end
end
