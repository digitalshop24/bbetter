module API
  module Entities
    class Base < Grape::Entity
      format_with :timestamp do |date|
        date.strftime('%Y-%m-%dT%H:%M:%S') if date
      end

      def self.desc attr
        I18n.t("activerecord.attributes.#{name.demodulize.downcase}.#{attr}")
      end

      format_with :image_styles do |image|
        styles = image.styles.keys << :original
        hash = {}
        styles.each do |style|
          hash[style] = image.url(style)
        end
        hash
      end
    end
  end
end

module SharedParams
  extend Grape::API::Helpers

  params :pagination do
    optional :page, type: Integer
    optional :per_page, type: Integer
  end
end

module API
  module V1
    class Root < Grape::API
      format :json
      content_type :json, "application/json;charset=UTF-8"
      version 'v1'
      rescue_from :all, backtrace: true
      rescue_from ActiveRecord::RecordNotFound do |e|
        error!({ ru: "Такая запись не найдена", en: "This record does not exists" }, 404)
      end
      error_formatter :json, ::API::ErrorFormatter
      mount API::V1::Users
      mount API::V1::Auth
      mount API::V1::Tariffs
      mount API::V1::Galleries
      mount API::V1::Videos
    end
  end
end
