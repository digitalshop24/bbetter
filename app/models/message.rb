class Message < ActiveRecord::Base
  belongs_to :user
  enum message_type: %i(from_user to_user)

  validates :user, :text, :message_type, presence: true

  def message_type_enum
     Message.message_types.map{ |key, value| [I18n.t("activerecord.attributes.message.message_types.#{key}"), key] }
  end

  rails_admin do
    edit do
      field :user
      field :text
      field :message_type
    end
    show do
      field :user
      field :text
      field :message_type do
        pretty_value do
          I18n.t("activerecord.attributes.message.message_types.#{bindings[:object].message_type}")
        end
      end
    end
    list do
      field :id
      field :user
      field :message_type do
        pretty_value do
          I18n.t("activerecord.attributes.message.message_types.#{bindings[:object].message_type}")
        end
      end
      field :text
    end
  end
end
