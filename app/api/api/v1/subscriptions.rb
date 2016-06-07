module API
  module V1
    class Subscriptions < Grape::API
      resource :subscriptions, desc: 'Подписки' do
        helpers SharedParams
        helpers do
          include API::AuthHelper
          include API::ErrorMessagesHelper
        end

        before do
          error!(error_message(:auth), 401) unless authenticated
        end

        desc "Активированные каналы подписки юзера"
        get do
          current_user.subscriptions.pluck(:channel)
        end

        desc "Активировать канал"
        params do
          requires :channel, type: String, desc: 'Канал', values: ::Subscription.channels.keys
        end
        post do
          current_user.subscriptions.create!(subscription_type: SubscriptionType.main, channel: params[:channel])
          status 201
          current_user.subscriptions.pluck(:channel)
        end

        desc "Деактивировать канал"
        params do
          requires :channel, type: String, desc: 'Канал', values: ::Subscription.channels.keys
        end
        delete do
          current_user.subscriptions.find_by(subscription_type: SubscriptionType.main, channel: params[:channel]).destroy!
          current_user.subscriptions.pluck(:channel)
        end
      end
    end
  end
end
