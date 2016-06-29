class UserTariff < ActiveRecord::Base
  belongs_to :user
  belongs_to :tariff
  belongs_to :training_program
  enum status: %i(active inactive)
end
