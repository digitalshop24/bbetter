class HomeController < ApplicationController
  layout 'home'
  def index
    @user = User.new
  end

  def profile
    @user = current_user
    @summaries = current_user.summaries
    @tariffs = Tariff.all
    @user_tariff = UserTariff.where(user_id: @user.id).first
    if @user_tariff.present?
      @current_tarrif = Tariff.find(@user_tariff.tariff_id)
    end
  end
end
