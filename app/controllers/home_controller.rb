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
  end
end
