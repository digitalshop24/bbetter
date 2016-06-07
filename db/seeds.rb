puts 'destroying users...'
User.destroy_all
puts 'creating admin...'
u = User.create(email: 'admin@bbetter.ru', password: 'password')
u.add_role :admin

puts 'destroying tariffes...'
Tariff.destroy_all

puts 'destroying subscription types'
SubscriptionType.destroy_all
puts 'creating subscription types'
SubscriptionType.create(name: 'Подписка', key: 'sub')
