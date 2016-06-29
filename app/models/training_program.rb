class TrainingProgram < ActiveRecord::Base
  has_many :user_tariffs, dependent: :nullify
  has_many :user, through: :user_tariffs
end
