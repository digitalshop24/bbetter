module API
  module Entities
    class Summary < Base
      expose :id, documentation: { type: Integer, desc: 'Id' }
      expose :before, documentation: { type: String, desc: 'Фото "до"' } do |obj|
        obj.before.url(:big) if obj.before?
      end
      expose :after, documentation: { type: String, desc: 'Фото "после"' } do |obj|
        obj.after.url(:big) if obj.after?
      end
      expose :motivation, documentation: { type: String, desc: 'Фото "мотивация"' } do |obj|
        obj.motivation.url(:big) if obj.motivation?
      end
      expose :weight, documentation: { type: Integer, desc: 'Вес' }
      expose :height, documentation: { type: Integer, desc: 'Рост' }
      expose :age, documentation: { type: Integer, desc: 'Возраст' }
      expose :chest, documentation: { type: Integer, desc: 'Грудь' }
      expose :waist, documentation: { type: Integer, desc: 'Талия' }
      expose :thigh, documentation: { type: Integer, desc: 'Бедра' }
      expose :motivation_words, documentation: { type: String, desc: 'Мотивация' }
    end
  end
end

module API
  module V1
    class Summaries < Grape::API
      resource :summaries, desc: 'Отчеты' do
        include Grape::Kaminari
        helpers SharedParams
        helpers do
          include API::AuthHelper
          include API::ErrorMessagesHelper

          def image_wrapper img
            image = Paperclip.io_adapters.for(img)
            ext = img[0..20].match(/data:image\/([a-z]{3,4});/)[1]
            image.original_filename = "#{[*('a'..'z'),*('0'..'9')].shuffle[0,8].join}.#{ext}"
            image
          end

          def summary_params
            pp = ActionController::Parameters.new(params).permit(
              :weight, :height, :age, :chest, :waist, :thigh, :motivation_words              
            )
            %i(before after motivation).each do |img_param|
              pp[img_param] = image_wrapper(params[img_param]) if params[img_param].present?
            end
            pp
          end
        end

        before do
          error!(error_message(:auth), 401) unless authenticated
        end

        desc "Все отчеты",
          entity: API::Entities::Summary,
          headers: { 'Auth-Token' => { description: 'Токен авторизации', required: true } },
          is_array: true
        paginate
        get http_codes: [
          { code: 401, message: "Ошибка авторизации" }
        ] do
          present paginate(current_user.summaries), with: API::Entities::Summary
        end

        desc "Создать отчет", entity: API::Entities::Summary,
          headers: { 'Auth-Token' => { description: 'Токен авторизации', required: true } }
        params do
          optional :before, type: String, desc: 'Фото "до"', allow_blank: true
          optional :after, type: String, desc: 'Фото "после"', allow_blank: true
          optional :motivation, type: String, desc: 'Фото "мотивация"', allow_blank: true
          optional :weight, type: Integer, desc: 'Вес', allow_blank: true
          optional :height, type: Integer, desc: 'Рост', allow_blank: true
          optional :age, type: Integer, desc: 'Возраст', allow_blank: true
          optional :chest, type: Integer, desc: 'Грудь', allow_blank: true
          optional :waist, type: Integer, desc: 'Талия', allow_blank: true
          optional :thigh, type: Integer, desc: 'Бедра', allow_blank: true
          optional :motivation_words, type: String, desc: 'Мотивация', allow_blank: true
        end
        post http_codes: [
          { code: 401, message: "Ошибка авторизации" }
        ] do
          summary = current_user.summaries.create!(summary_params)
          present summary, with: API::Entities::Summary
        end

        desc "Обновить отчет", entity: API::Entities::Summary,
          headers: { 'Auth-Token' => { description: 'Токен авторизации', required: true } }
        params do
          requires :id, type: Integer, desc: 'Id'
          optional :before, type: String, desc: 'Фото "до"', allow_blank: true
          optional :after, type: String, desc: 'Фото "после"', allow_blank: true
          optional :motivation, type: String, desc: 'Фото "мотивация"', allow_blank: true
          optional :weight, type: Integer, desc: 'Вес', allow_blank: true
          optional :height, type: Integer, desc: 'Рост', allow_blank: true
          optional :age, type: Integer, desc: 'Возраст', allow_blank: true
          optional :chest, type: Integer, desc: 'Грудь', allow_blank: true
          optional :waist, type: Integer, desc: 'Талия', allow_blank: true
          optional :thigh, type: Integer, desc: 'Бедра', allow_blank: true
          optional :motivation_words, type: String, desc: 'Мотивация', allow_blank: true
        end
        put '/:id', http_codes: [
          { code: 401, message: "Ошибка авторизации" },
          { code: 404, message: "Отчет с таким id не найден" }
        ] do
          summary = current_user.summaries.find(params[:id])
          summary.update!(summary_params)
          present summary, with: API::Entities::Summary
        end

        desc "Удалить отчет",
          headers: { 'Auth-Token' => { description: 'Токен авторизации', required: true } }
        params do
          requires :id, type: Integer, desc: 'Id'
        end
        delete '/:id', http_codes: [
          { code: 401, message: "Ошибка авторизации" },
          { code: 404, message: "Отчет с таким id не найден" }
        ] do
          summary = current_user.summaries.find(params[:id]).destroy!
          present :status, 'ok'
        end

      end
    end
  end
end
