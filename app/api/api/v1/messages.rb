module API
  module Entities
    class Message < Base
      expose :id, documentation: { type: Integer,  desc: 'id' }
      expose :text, documentation: { type: String,  desc: desc('text') }
      expose :message_type, documentation: { type: String,  desc: desc('message_type') }
    end
  end
end

module API
  module V1
    class Messages < Grape::API
      resource :messages, desc: 'Тарифы' do
        include Grape::Kaminari
        helpers SharedParams
        helpers do
          include API::AuthHelper
          include API::ErrorMessagesHelper
        end

        before do
          error!(error_message(:auth), 401) unless authenticated
        end

        desc "Список всех сообщений",
          entity: API::Entities::Message,
          headers: { 'Auth-Token' => { description: 'Токен авторизации', required: true } },
          is_array: true
        paginate
        get http_codes: [
          { code: 401, message: "Ошибка авторизации" }
        ] do
          present paginate(current_user.messages), with: API::Entities::Message
        end

        desc "Написать сообщение", entity: API::Entities::Message,
          headers: { 'Auth-Token' => { description: 'Токен авторизации', required: true } }
        params do
          requires :text, type: String, desc: 'Текст сообщения'
        end
        post http_codes: [
          { code: 401, message: "Ошибка авторизации" }
        ] do
          msg = current_user.messages.create!(text: params[:text])
          present msg, with: API::Entities::Message
        end

      end
    end
  end
end
