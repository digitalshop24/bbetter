class UserMailer < ApplicationMailer
	URL = ENV['host']
	def password_email user, password
		@user, @password, @url = user, password, URL
    mail(to: @user.email, subject: 'Успешная регистрация на сайте')
	end
	def restore_password_email user, password
		@user, @password, @url = user, password, URL
    mail(to: @user.email, subject: 'Новый пароль')
	end
	def subscription_email email, message, subject
		@message = message
		mail(to: email, subject: subject)
	end
	def promocode_email user, email, promocode
		@user, @promocode = user, promocode
		mail(to: email, subject: 'Приглашение на сайт bbetter.club')
	end
	def pay_reminder_email user
		@user = user
		mail(to: @user.email, subject: 'Напоминание об оплате')
	end
	def feedback_info_email email, feedback
		@feedback = feedback
		mail(to: email, subject: 'Новое сообщение через форму обратной связи', from: "\"#{@feedback.name}\" <#{@feedback.email}>")
	end
end
