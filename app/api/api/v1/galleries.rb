module API
  module Entities
    class Image < Base
      expose :id, documentation: { type: Integer,  desc: desc(:id) }
      expose :image, documentation: { type: String,  desc: desc(:image) }, format_with: :image_styles
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
      expose :images, documentation: { type: String,  desc: desc(:images) }, using: API::Entities::Image
    end
  end
end

module API
  module V1
    class Galleries < Grape::API
      helpers do
        include API::AuthHelper
        include API::ErrorMessagesHelper
      end
      before do
        error!(error_message(:auth), 401) unless authenticated
      end

      resource :galleries, desc: 'Галереи' do
        desc "Все галлереи с картинками", entity: API::Entities::Gallery
        get do
          present :items, current_user.galleries, with: API::Entities::Gallery
        end

        desc "Создать галерею", entity: API::Entities::Gallery
        post do
          gallery = current_user.galleries.create!

          present :item, gallery, with: API::Entities::Gallery
          present :status, 'ok'
        end

        desc 'Удалить галерею'
        params do
          requires :gallery_id, type: Integer, desc: 'Id галереи'
        end
        delete '/:gallery_id' do
          current_user.galleries.find(params[:gallery_id]).destroy!
          present :status, 'ok'
        end

        desc 'Загрузить картинку'
        params do
          requires :gallery_id, type: Integer, desc: 'Id галереи'
          requires :image, type: String, desc: 'Изображение'
          requires :image_type, type: String, desc: 'Тип картинки', values: ::Image::IMAGE_TYPES
        end
        post '/:gallery_id/images' do
          gallery = current_user.galleries.find(params[:gallery_id])
          image = Paperclip.io_adapters.for(params[:image])
          ext = params[:image][0..20].match(/data:image\/([a-z]{3,4});/)[1]
          image.original_filename = "#{[*('a'..'z'),*('0'..'9')].shuffle[0,8].join}.#{ext}"
          img = gallery.images.create!(image: image, image_type: params[:image_type])
          present img, with: API::Entities::ImageFull
        end

        desc 'Удалить картинку'
        params do
          requires :gallery_id, type: Integer, desc: 'Id картинки'
          requires :image_id, type: Integer, desc: 'Id картинки'
        end
        delete '/:gallery_id/images/:image_id' do
          current_user.images.find(:image_id).destroy!
          present :status, 'ok'
        end
      end
    end
  end
end
