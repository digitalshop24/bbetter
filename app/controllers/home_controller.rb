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

  def registration
    generated_password = Devise.friendly_token.first(8)
    @user = User.new(user_params.merge(password: generated_password))
    pc = nil
    tariff = nil
    if params[:promocode].present?
      pc = Promocode.available.find_by(code: params[:promocode])
      @user.errors << "Промокод имеет неверное значение" unless pc
      tariff = Tariff.find_by(people_number: 1)
      @user.errors << "Нету подходящего тарифа" unless tariff
    end
    pc.update(activated_at: Time.now, user: @user) if pc
    UserTariff.create(user: @user, tariff: tariff)
    sign_in(:user, @user)
    begin
      UserMailer.password_email(user, generated_password).deliver_now
      flash[:info] = 'Пароль был отправлен на почту'
    rescue => error
      flash[:info] = "Пароль не был отправлен на почту, потому что #{error.message}"
    end
    if @user.save
      flash[:info] = "Регистрация не было успешной"
      redirect_to :profile
    else
      flash[:modal] = 'regModal'
      render 'index'
    end
  end

  private
  def user_params
    params[:user].permit(:email, :name, :city, :age, :sex, :motivation)
  end
end
