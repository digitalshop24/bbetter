class UserTariff < ActiveRecord::Base
  belongs_to :user
  belongs_to :tariff
  enum status: %i(active inactive)
end
