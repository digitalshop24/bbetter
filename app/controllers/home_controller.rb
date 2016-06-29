class HomeController < ApplicationController
  before_action :authenticate_user!, only: :profile
  layout 'home'
  def index
    @user = current_user || User.new
  end

  # def registration
  #   pc = nil
  #   tariff = nil
  #   if params[:promocode].present?
  #     pc = Promocode.available.find_by(code: params[:promocode])
  #     if !pc.present?
  #       redirect_to :back, flash: {new_solution_errors: "промокод недействителен"}
  #       return false
  #     end
  #     tariff = Tariff.find_by(people_number: 1)
  #     error!(error_message(:no_suitebale_tariff), 406) unless tariff
  #   end
  #   generated_password = Devise.friendly_token.first(8)
  #   begin
  #     user = User.create!(name: params[:name], city: params[:city], age: params[:age], email: params[:email], password: generated_password)
  #   rescue =>e
  #     @error= e.message
  #     redirect_to :back, flash: {new_solution_errors: @error}
  #     return false
  #     #render :partial => 'modals'
  #   end
  #   pc.update(activated_at: Time.now, user: user) if pc
  #   UserTariff.create(user: user, tariff: tariff) if pc
  #   sign_in(:user, user)
  #   begin
  #     UserMailer.password_email(user, generated_password).deliver_now
  #     info = 'Пароль был отправлен на почту'
  #   rescue => error
  #     info = "Пароль не был отправлен на почту, потому что #{error.message}"
  #   end
  #   redirect_to '/profile'
  # end

  def profile
    @user = current_user
    @summaries = current_user.summaries
    @tariffs = Tariff.all
    @user_tariff = UserTariff.where(user_id: @user.id).first
    if @user_tariff.present?
      @current_tarrif = Tariff.find(@user_tariff.tariff_id)
    end
  end

  def edit_profile
    @user = current_user
    if @user.update(user_params)
      if params[:promocode].present?
        pc = Promocode.available.find_by(code: params[:promocode])
        tariff = Tariff.find_by(people_number: 1)
        if pc && tariff
          pc.update(activated_at: Time.now, user: @user)
          UserTariff.create(user: @user, tariff: tariff)
        else
          @user.errors[:promocode] << "имеет неверное значение" unless pc
          @user.errors[:promocode] << "нету подходящего тарифа" unless tariff
        end
      end
    end
    if @user.errors.present?
      flash[:modal] = 'editProfileModal'
      flash[:new_solution_errors] = @user.errors.full_messages
    end
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
    if @user.errors.empty? && @user.save
      if pc && tariff
        pc.update(activated_at: Time.now, user: @user)
        UserTariff.create(user: @user, tariff: tariff)
      end
      begin
        UserMailer.password_email(@user, generated_password).deliver_now
        flash[:info] = 'Пароль был отправлен на почту'
      rescue => error
        flash[:info] = "Пароль не был отправлен на почту, потому что #{error.message}"
      end
      flash[:info] = "Вы успешно зарегистрировались"
      sign_in(:user, @user)
      redirect_to :profile
    else
      flash[:info] = "Регистрация не было успешной"
      flash[:new_solution_errors] = @user.errors.full_messages
      flash[:modal] = 'regModal'
      render 'index'
    end
  end

  private
  def user_params
    params[:user].permit(:email, :name, :city, :age, :sex, :motivation)
  end
end
