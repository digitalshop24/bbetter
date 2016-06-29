class UserTariffsController < ApplicationController
  def set_training_program
    @user_tariff = UserTariff.find(params[:id])
    if @user_tariff.update(training_program_id: params[:user_tariff][:training_program_id])
      redirect_to :back
    else
    end
  end
end
