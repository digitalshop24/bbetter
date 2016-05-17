class UserMailer < ApplicationMailer
	URL = ENV['host']
	def password_email user, password
		@user, @password, @url = user, password, URL
    mail(to: @user.email, subject: 'Успешная регистрация на сайте')
	end
end