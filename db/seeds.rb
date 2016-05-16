puts 'destroying users...'
User.destroy_all
puts 'creating admin...'
u = User.create(email: 'admin@bbetter.ru', password: 'password')
u.add_role :admin