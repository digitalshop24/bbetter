class Image < ActiveRecord::Base
  belongs_to :gallery

  IMAGE_TYPES = %w(before after want)

  has_attached_file :image, styles: { medium: "700x700>", thumb: "200x200>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  def image_type_enum
    IMAGE_TYPES.map{ |image_type| [I18n.t("activerecord.attributes.image.image_types.#{image_type}"), image_type] }
  end

  rails_admin do
    edit do
      fields :image, :gallery, :image_type
    end
    show do
      field :image
      field :gallery
      field :image_type do
        pretty_value do
          I18n.t("activerecord.attributes.image.image_types.#{value}") if value.present?
        end
      end
    end
    list do
      field :image
      field :image_type do
        pretty_value do
          I18n.t("activerecord.attributes.image.image_types.#{value}") if value.present?
        end
      end
    end
  end
end
