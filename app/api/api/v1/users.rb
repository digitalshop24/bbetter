module API
  module Entities
    class User < Base
      expose :name, documentation: { type: String, desc: "Имя" }
      expose :email, documentation: { type: String, desc: "Email" }
      expose :city, documentation: { type: String, desc: "Город" }
      expose :age, documentation: { type: String, desc: "Возраст" }
      expose :sex, documentation: { type: String, desc: "Пол" }
      expose :motivation, documentation: { type: String, desc: "Мотивация" }
    end

    class UserWithToken < User
      expose :auth_token, documentation: { type: String,  desc: "Токен" }
    end
  end
end

module API
  module V1
    class Users < Grape::API
      helpers do
        include API::AuthHelper
        include API::ErrorMessagesHelper
      end
      resource :users, desc: 'Пользователи' do
        desc "Текущий пользователь", entity: API::Entities::User,
          headers: { 'Auth-Token' => { description: 'Токен авторизации', required: true } }
        get '/current', http_codes: [
          { code: 401, message: "Ошибка авторизации" }
        ] do
          error!(error_message(:auth), 401) unless authenticated

          present current_user, with: API::Entities::User
        end
      end
    end
  end
end
