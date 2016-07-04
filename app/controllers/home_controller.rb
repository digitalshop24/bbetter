class HomeController < ApplicationController
  before_action :authenticate_user!, only: [:profile, :edit_profile, :promo, :send_promo]
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
    @message = Message.new
    @user = current_user
    @tariffs = Tariff.all
    @user_tariff = UserTariff.where(user_id: @user.id).last
    @summary = @user.summary || Summary.new
    if @user_tariff.present?
      @current_tarrif = Tariff.find(@user_tariff.tariff_id)
    end
  end

  def edit_profile
    @user = current_user
    if @user.update(user_params)
      if params[:promocode].present?
        pc = Promocode.not_activated.find_by(code: params[:promocode])
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
    flash[:info_messages] = []
    if params[:promocode].present?
      pc = Promocode.not_activated.find_by(code: params[:promocode])
      @user.errors[:promocode] << "имеет неверное значение" unless pc
      tariff = Tariff.find_by(people_number: 1)
      @user.errors[:promocode] << "нету подходящего тарифа" unless tariff
    end
    if @user.errors.empty? && @user.save
      flash[:info_messages] << 'Вы успешно зарегистрировались'
      if pc && tariff
        pc.update(activated_at: Time.now, user: @user)
        UserTariff.create(user: @user, tariff: tariff)
      end
      begin
        UserMailer.password_email(@user, generated_password).deliver_now
        flash[:info_messages] << 'Пароль был отправлен на почту'
      rescue => error
        flash[:info_messages] << "Пароль не был отправлен на почту, потому что #{error.message}"
      end
      sign_in(:user, @user)
      redirect_to :profile
    else
      flash[:new_solution_errors] = @user.errors.full_messages
      flash[:modal] = 'regModal'
      render 'index'
    end
  end

  def promo
    @user = current_user
    @promocodes = @user.promocodes
    @user_tariff = @user.user_tariffs.last
    @current_tarrif = @user_tariff.tariff if @user_tariff.present?
  end

  def send_promo
    if params[:accPromo] == 'phone'
      unless params[:phone].present?
        render json: { status: 'error', errors: ['Не введен номер телефона'] }
        return
      end
      render json: { status: 'ok', message: 'Приглашение успешно отправлено' }
    elsif params[:accPromo] == 'email'
      unless params[:email].present?
        render json: { status: 'error', errors: ['Не введен email'] }
        return
      end
      begin
        UserMailer.promocode_email(current_user, params[:email], params[:promocode]).deliver_now
        render json: { status: 'ok', message: 'Приглашение успешно отправлено' }
      rescue => error
        render json: { status: 'error', errors: ["Ошибка при отправке email: #{error.message}"] }
      end
    else
      render json: { status: 'error', errors: ['Что-то пошло не так'] }
    end


    # elsif params[:promocode].present? && params[:email].present?
    #   res = 'email '
    # else

    # end
    # render json: { result: }
  end
  def forum
    @user = User.new
  end

  def unsubscribe
    user = User.find_by_auth_token(params[:auth_token]) if params[:auth_token].present?
    user.update(subscribed: false)
    render text: '<h2 style="text-align:center;">Вы отказались от рассылок</h2>'.html_safe
  end

  def restore_password
    flash[:info_messages] = []
    @user = User.find_by(email: params[:user][:email])
    if @user
      new_password = Devise.friendly_token.first(8)
      @user.update(password: new_password)
      begin
        UserMailer.restore_password_email(@user, new_password).deliver_now
        flash[:info_messages] << 'Пароль был отправлен на почту'
      rescue => error
        flash[:info_messages] << "Пароль не был отправлен на почту, потому что #{error.message}"
      end
      flash[:modal] = 'signInModal'
      redirect_to :back
    else
      flash[:new_solution_errors] = ['Пользователь с таким email не найден']
      flash[:modal] = 'restorePasModal'
      redirect_to :back
    end
  end

  private
  def user_params
    params[:user].permit(:email, :name, :city, :age, :sex, :motivation, :phone, :moto)
  end
end
