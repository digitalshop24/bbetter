class TrainingProgram < ActiveRecord::Base
  WEEK_START_NUMBER = 28
  has_many :user_tariffs, dependent: :nullify
  has_many :user, through: :user_tariffs
end
