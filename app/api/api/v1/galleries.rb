module API
  module Entities
    class Image < Base
      expose :id, documentation: { type: Integer,  desc: desc(:id) }
      expose :image, documentation: { type: Hash,  desc: desc(:image) }, format_with: :image_styles
      expose :image_type, documentation: { type: String,  desc: desc(:image_type) }
    end
    class ImageFull < Image
      expose :gallery_id, documentation: { type: Integer,  desc: desc(:gallery_id) }
    end
  end
end

module API
  module Entities
    class Gallery < Base
      expose :id, documentation: { type: Integer,  desc: desc(:id) }
      expose :images, documentation: { type: API::Entities::Image, desc: desc(:images), is_array: true }, using: API::Entities::Image
    end
  end
end

module API
  module V1
    class Galleries < Grape::API
      include Grape::Kaminari
      helpers SharedParams
      helpers do
        include API::AuthHelper
        include API::ErrorMessagesHelper
      end
      before do
        error!(error_message(:auth), 401) unless authenticated
      end

      resource :galleries, desc: 'Галереи' do
        desc "Все галереи с картинками",
          entity: API::Entities::Gallery,
          headers: { 'Auth-Token' => { description: 'Токен авторизации', required: true } },
          is_array: true
        paginate
        get http_codes: [
          { code: 401, message: "Ошибка авторизации" }
        ] do
          present paginate(current_user.galleries), with: API::Entities::Gallery
        end

        desc "Создать галерею",
          entity: API::Entities::Gallery,
          headers: { 'Auth-Token' => { description: 'Токен авторизации', required: true } }
        post http_codes: [
          { code: 401, message: "Ошибка авторизации" }
        ] do
          gallery = current_user.galleries.create!

          present gallery, with: API::Entities::Gallery
        end

        desc 'Удалить галерею',
          headers: { 'Auth-Token' => { description: 'Токен авторизации', required: true } }
        params do
          requires :gallery_id, type: Integer, desc: 'Id галереи'
        end
        delete '/:gallery_id', http_codes: [
          { code: 401, message: "Ошибка авторизации" },
          { code: 404, message: "Галерея с таким id не найдена" }
        ]  do
          current_user.galleries.find(params[:gallery_id]).destroy!
          present :status, 'ok'
        end

        desc 'Загрузить картинку', entity: API::Entities::ImageFull,
          headers: { 'Auth-Token' => { description: 'Токен авторизации', required: true } }
        params do
          requires :gallery_id, type: Integer, desc: 'Id галереи'
          requires :image, type: String, desc: 'Изображение'
          requires :image_type, type: String, desc: 'Тип картинки', values: ::Image::IMAGE_TYPES
        end
        post '/:gallery_id/images', http_codes: [
          { code: 401, message: "Ошибка авторизации" },
          { code: 404, message: "Галерея с таким id не найдена" }
        ] do
          gallery = current_user.galleries.find(params[:gallery_id])
          image = Paperclip.io_adapters.for(params[:image])
          ext = params[:image][0..20].match(/data:image\/([a-z]{3,4});/)[1]
          image.original_filename = "#{[*('a'..'z'),*('0'..'9')].shuffle[0,8].join}.#{ext}"
          img = gallery.images.create!(image: image, image_type: params[:image_type])
          present img, with: API::Entities::ImageFull
        end

        desc 'Удалить картинку',
          headers: { 'Auth-Token' => { description: 'Токен авторизации', required: true } }
        params do
          requires :gallery_id, type: Integer, desc: 'Id картинки'
          requires :image_id, type: Integer, desc: 'Id картинки'
        end
        delete '/:gallery_id/images/:image_id', http_codes: [
          { code: 401, message: "Ошибка авторизации" },
          { code: 404, message: "Картинка с таким id не найдена" }
        ] do
          current_user.images.find(:image_id).destroy!
          present :status, 'ok'
        end
      end
    end
  end
end
