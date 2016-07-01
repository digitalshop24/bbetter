class MessagesController < ApplicationController
  before_action :authenticate_user!
	def create
		message = current_user.messages.create(message_params)
		res = message.errors.any? ? 'Ошибка при отправке сообщения' : 'Ваше сообщение отправлено' 
		render json: { result: res }
	end

	private
	def message_params
		params[:message].permit(:text, :theme)
	end
end