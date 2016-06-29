class HomeController < ApplicationController
  before_action :authenticate_user!, only: :profile
  layout 'home'
  def index
    @user = current_user || User.new
  end

  def profile
    @user = current_user
    @summaries = current_user.summaries if @user
    @tariffs = Tariff.all
  end

  def edit_profile
    @user = current_user
    @user.update(user_params)
    redirect_to :back
  end

  def registration
    generated_password = Devise.friendly_token.first(8)
    @user = User.new(user_params.merge(password: generated_password))
    pc = nil
    tariff = nil
    if params[:promocode].present?
      pc = Promocode.available.find_by(code: params[:promocode])
      @user.errors[:promocode] << "имеет неверное значение" unless pc
      tariff = Tariff.find_by(people_number: 1)
      @user.errors[:promocode] << "нету подходящего тарифа" unless tariff
    end
    if @user.save
      pc.update(activated_at: Time.now, user: @user) if pc
      UserTariff.create(user: @user, tariff: tariff)
      begin
        UserMailer.password_email(user, generated_password).deliver_now
        flash[:info] = 'Пароль был отправлен на почту'
      rescue => error
        flash[:info] = "Пароль не был отправлен на почту, потому что #{error.message}"
      end
      flash[:info] = "Вы успешно зарегистрировались"
      sign_in(:user, @user)
      redirect_to :profile
    else
      binding.pry
      flash[:info] = "Регистрация не было успешной"
      flash[:modal] = 'regModal'
      render 'index'
    end
  end

  private
  def user_params
    params[:user].permit(:email, :name, :city, :age, :sex, :motivation)
  end
end
