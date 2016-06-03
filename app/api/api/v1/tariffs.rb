module API
  module Entities
    class Tariff < Base
      expose :name, documentation: { type: Integer,  desc: desc('name') }
      expose :price, documentation: { type: Integer,  desc: desc('price') }
      expose :people_number, documentation: { type: Integer,  desc: desc('people_number') }
      expose :short_content, documentation: { type: Integer,  desc: desc('short_content') }
      expose :full_content, documentation: { type: Integer,  desc: desc('full_content') }
      expose :image, documentation: { type: Integer,  desc: desc('image') }, format_with: :image_styles
      expose :additional_image, documentation: { type: Integer,  desc: desc('additional_image') }, format_with: :image_styles
    end
  end
end

module API
  module V1
    class Tariffs < Grape::API
      resource :tariffs, desc: 'Тарифы' do
        desc "Список всех тарифов", entity: API::Entities::Tariff
        get  do
          present Tariff.all, with: API::Entities::Tariff
        end
      end
    end
  end
end