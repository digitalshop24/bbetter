class MessagesController < ApplicationController
  before_action :authenticate_user!
	def create
		current_user.messages.create(message_params)
		render json: { result: 'Ваше сообщение отправлено' }
	end

	private
	def message_params
		params[:message].permit(:text, :theme)
	end
end