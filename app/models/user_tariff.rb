class UserTariff < ActiveRecord::Base
  belongs_to :user
  belongs_to :tariff
  enum status: %i(payment_waiting active inactive expired not_payed)
end
