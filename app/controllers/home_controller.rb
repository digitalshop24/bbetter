class HomeController < ApplicationController
  layout 'home'
  def index
    @user = User.new
  end

  def registration
    pc = nil
    tariff = nil
    if params[:promocode].present?
      pc = Promocode.available.find_by(code: params[:promocode])
      if !pc.present?
       redirect_to :back, flash: {new_solution_errors: "промокод недействителен"}
       return false
      end
      tariff = Tariff.find_by(people_number: 1)
      error!(error_message(:no_suitebale_tariff), 406) unless tariff
    end
    generated_password = Devise.friendly_token.first(8)
    begin
      user = User.create!(name: params[:name], city: params[:city], age: params[:age], email: params[:email], password: generated_password)
    rescue =>e
       @error= e.message
       redirect_to :back, flash: {new_solution_errors: @error}
       return false
       #render :partial => 'modals'
    end
    pc.update(activated_at: Time.now, user: user) if pc
    UserTariff.create(user: user, tariff: tariff) if pc
    sign_in(:user, user)
    begin
      UserMailer.password_email(user, generated_password).deliver_now
      info = 'Пароль был отправлен на почту'
    rescue => error
      info = "Пароль не был отправлен на почту, потому что #{error.message}"
    end
    redirect_to '/profile'
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
