class AddTrainingProgramToUserTariff < ActiveRecord::Migration
  def change
    add_reference :user_tariffs, :training_program, index: true, foreign_key: true
  end
end
