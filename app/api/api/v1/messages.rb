module API
  module Entities
    class Message < Base
      expose :id, documentation: { type: String,  desc: 'id' }
      expose :text, documentation: { type: String,  desc: desc('text') }
      expose :message_type, documentation: { type: String,  desc: desc('message_type') }
    end
  end
end

module API
  module V1
    class Messages < Grape::API
      resource :messages, desc: 'Тарифы' do
        helpers SharedParams
        helpers do
          include API::AuthHelper
          include API::ErrorMessagesHelper
        end

        before do
          error!(error_message(:auth), 401) unless authenticated
        end

        desc "Список всех сообщений", entity: API::Entities::Message
        params { use :pagination }
        get do
          messages = current_user.messages.page(params[:page]).per(params[:per_page])
          present :total, messages.total_count
          present :items, messages, with: API::Entities::Message
        end

        desc "Написать сообщение", entity: API::Entities::Message
        params do
          requires :text, type: String, desc: 'Текст сообщения'
        end
        post do
          msg = current_user.messages.create!(text: params[:text])
          status 201
          present msg, with: API::Entities::Message
        end

      end
    end
  end
end
