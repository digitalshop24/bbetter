class FeedbacksController < ApplicationController
	skip_before_filter :verify_authenticity_token

	def create
		feedback = Feedback.create(feedback_params)
		res = feedback.errors.any? ? 'Ошибка при отправке сообщения' : 'Ваше сообщение отправлено'
		render json: { result: res }
	end

	private
	def feedback_params
		params[:feedback].permit(:name, :email, :theme, :message, :sender_type)
	end
end
