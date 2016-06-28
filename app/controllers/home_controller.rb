class HomeController < ApplicationController
	before_action :authenticate_user!, only: :profile
  layout 'home'
  def index
    @user = User.new
  end

  def profile
    @user = current_user
    @summaries = current_user.summaries if @user
    @tariffs = Tariff.all
    @user_tariff = UserTariff.where(user_id: @user.id).first
  end
end
