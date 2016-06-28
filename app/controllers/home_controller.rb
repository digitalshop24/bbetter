class HomeController < ApplicationController
  layout 'home'
  def index
    @user = User.new
  end

  def profile
    @user = current_user
    @summaries = current_user.summaries
    @tariffs = Tariff.all
  end
end
