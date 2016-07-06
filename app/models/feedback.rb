class Feedback < ActiveRecord::Base
	INFO_EMAIL = ENV['info_email']
	after_create :send_info_email

	private
	def send_info_email
		UserMailer.feedback_info_email(INFO_EMAIL, self).deliver_now
	end
end
