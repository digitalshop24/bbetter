require 'action_controller/metal/strong_parameters'

module API
  module V1
    class Auth < Grape::API
      helpers do
        include API::AuthHelper
        include API::ErrorMessagesHelper

        def user_params
          ActionController::Parameters.new(params).permit(
            :email, :name, :city, :age, :sex, :motivation
          )
        end

        def change_user_password_params
          ActionController::Parameters.new(params).permit(:password, :password_confirmation)
        end
      end

      resource :users, desc: 'Пользователи' do
        desc "Регистрация пользователя", entity: API::Entities::UserWithToken
        params do
          requires :name, type: String, desc: "Имя"
          requires :email, type: String, desc: "Email", regexp: { value: /\A[a-zA-Z\d\-_\+\.]+@[a-zA-Z\-\d\.]+\.[a-zA-Z]{1,15}\z/, message: { ru: 'Email имеет неверный формат', en: "Invalid Email" } }
          requires :city, type: String, desc: "Город"
          requires :age, type: Integer, desc: "Возраст"
          requires :sex, type: String, desc: "Пол", values: %w(male female)
          optional :motivation, type: String, desc: "Мотивация"
          optional :promocode, type: String, desc: "Промокод"
        end
        post '/' do
          pc = nil
          tariff = nil
          if params[:promocode].present?
            pc = Promocode.available.find_by(code: params[:promocode])
            error!(error_message(:bad_promocode), 406) unless pc
            tariff = Tariff.find_by(people_number: 1)
            error!(error_message(:no_suitebale_tariff), 406) unless tariff
          end
          generated_password = Devise.friendly_token.first(8)
          user = User.create! user_params.merge(password: generated_password)
          pc.update(activated_at: Time.now, user: user) if pc
          UserTariff.create(user: user, tariff: tariff)
          sign_in(:user, user)
          begin
            UserMailer.password_email(user, generated_password).deliver_now
            info = 'Пароль был отправлен на почту'
          rescue => error
            info = "Пароль не был отправлен на почту, потому что #{error.message}"
          end
          present user, with: API::Entities::UserWithToken
        end

        desc 'Редактирование профиля',
          entity: API::Entities::User,
          headers: { 'Auth-Token' => { description: 'Токен авторизации', required: true } }
        params do
          optional :name, type: String, desc: "Имя"
          optional :email, type: String, desc: "Email", regexp: { value: /\A[a-zA-Z\d\-_\+\.]+@[a-zA-Z\-\d\.]+\.[a-zA-Z]{1,15}\z/, message: { ru: 'Email имеет неверный формат', en: "Invalid Email" } }
          optional :city, type: String, desc: "Город"
          optional :age, type: Integer, desc: "Возраст"
          optional :sex, type: String, desc: "Пол", values: %w(male female)
          optional :email, type: String, desc: "Email"
          optional :promocode, type: String, desc: "Промокод"
        end
        put '/edit', http_codes: [
          { code: 401, message: "Ошибка авторизации" }
        ] do
          error!(error_message(:auth), 401) unless authenticated
          if params[:promocode].present?
            pc = Promocode.available.find_by(code: params[:promocode])
            error!(error_message(:bad_promocode), 406) unless pc
            error!(error_message(:already_have_promocode), 406) if current_user.promocode
            tariff = Tariff.find_by(people_number: 1)
            error!(error_message(:no_suitebale_tariff), 406) unless tariff
            error!(error_message(:active_tariff), 406) if current_user.active_tariff
            pc.update!(user: current_user, activated_at: Time.now)
            UserTariff.create(user: current_user, tariff: tariff)
          end
          current_user.update!(user_params)
          present current_user, with: API::Entities::User
        end

        desc "Авторизация"
        params do
          requires :email, type: String, desc: "Email"
          requires :password, type: String, desc: "Пароль"
        end
        post '/sign_in', http_codes: [
          { code: 401, message: "Ошибка авторизации" }
        ] do
          user = User.find_by_email(params[:email].downcase)
          error!(error_message(:email_not_found), 401) unless user
          error!(error_message(:invalid_password), 401) unless user.valid_password?(params[:password])

          sign_in :user, user
          present user, with: API::Entities::UserWithToken
        end

        desc "Удалить токен - разлогиниться",
          headers: { 'Auth-Token' => { description: 'Токен авторизации', required: true } }
        delete 'sign_out', http_codes: [
          { code: 401, message: "Ошибка авторизации" }
        ] do
          error!(error_message(:auth), 401) unless authenticated
          sign_out(current_user) ? { status: 'ok' } : error!(error_message(:something_wrong), 500)
        end

        desc "Изменение пароля",
          headers: { 'Auth-Token' => { description: 'Токен авторизации', required: true } }
        params do
          requires :current_password, type: String, desc: "Текущий пароль"
          requires :password, type: String, desc: "Пароль"
          requires :password_confirmation, type: String, desc: "Подтверждение пароля"
        end
        put '/password/change', http_codes: [
          { code: 401, message: "Ошибка авторизации" },
          { code: 422, message: "Ошибка при обновлении пользователя" }
        ] do
          error!(error_message(:auth), 401) unless authenticated

          user = current_user
          if user.valid_password?(params[:current_password])
            if user.update(change_user_password_params)
              user.update(auth_token: nil)
              begin
                user.send_password_change_notification
                present :info, 'Email уведомление отправлено'
              rescue => error
                present :info, "Email уведомление не было отправлено, потому что #{error.message}"
              end
              present :user, user, with: API::Entities::UserWithToken
              present :status, 'ok'
            else
              error!(eng_format_errors(user.errors), 422)
            end
          else
            error!(error_message(:invalid_change_password), 401)
          end
        end

        desc "Отравить запрос на восстановление пароля"
        params do
          requires :email, type: String, desc: "Email"
        end
        post '/password', http_codes: [
          { code: 404, message: "Email не найден" }
        ] do
          user = User.find_by(email: params[:email])
          if user
            token = user.send_reset_password_instructions
            if token
              { status: 'ok' }
            end
          else
            error!(error_message(:email_not_found), 404)
          end
        end

        desc "Восстановление пароля", entity: API::Entities::User
        params do
          requires :reset_password_token, type: String, desc: "Reset Password Token"
          requires :password, type: String, desc: "Пароль"
          requires :password_confirmation, type: String, desc: "Подтверждение пароля"
        end

        put '/password/reset', http_codes: [
          { code: 422, message: "Ошибка при восстановлении пароля" }
        ]  do
          user = User.reset_password_by_token(params)
          if user.errors.empty?
            sign_in :user, user
            present user
          else
            error!(eng_format_errors(user.errors), 422)
          end
        end

      end
    end
  end
end
