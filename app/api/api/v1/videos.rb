module API
  module Entities
    class Video < Base
      expose :id, documentation: { type: Integer,  desc: 'id' }
      expose :day, documentation: { type: Integer,  desc: 'День' }
      expose :youtube_code, documentation: { type: Integer,  desc: desc('youtube_code') }
    end
  end
end

module API
  module V1
    class Videos < Grape::API
      helpers SharedParams
      include Grape::Kaminari
      helpers do
        include API::AuthHelper
        include API::ErrorMessagesHelper
      end

      before do
        error!(error_message(:auth), 401) unless authenticated
      end

      resource :videos, desc: 'Видео' do
        desc 'Все видео юзера',
          entity: API::Entities::Video,
          is_array: true,
          headers: { 'Auth-Token' => { description: 'Validates your identity', required: true } }
        paginate
        get do
          videos = current_user.videos
          present paginate(videos), with: API::Entities::Video
        end

        desc "Добавить видео",
          entity: API::Entities::Video,
          headers: { 'Auth-Token' => { description: 'Validates your identity', required: true } }
        params do
          requires :youtube_code, type: String, desc: 'Код видео на youtube (вида GXGm6uQQKe8)', regexp: /^[A-Za-z0-9\-]{11}$/
          requires :day, type: Integer, desc: 'Номер дня'
        end
        post do
          video = current_user.videos.create!(youtube_code: params[:youtube_code], day: params[:day])

          present video, with: API::Entities::Video
        end

        desc "Удалить видео",
          headers: { 'Auth-Token' => { description: 'Validates your identity', required: true } }
        params do
          requires :video_id, type: Integer, desc: 'Id видео'
        end
        delete '/:video_id'do
          current_user.videos.find(params[:video_id]).destroy!

          present :status, 'ok'
        end
      end
    end
  end
end
