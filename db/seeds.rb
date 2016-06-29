puts 'destroying users...'
User.destroy_all
puts 'creating admin...'
u = User.create(name: 'Админ', email: 'admin@bbetter.ru', password: 'password')
u.add_role :admin

puts 'destroying tariffes...'
Tariff.destroy_all
puts 'creating tariffes...'
Tariff.create(name: "Спортсмен одиночка", people_number: 1, price: 2000)
Tariff.create(name: "Парный старт", people_number: 2, price: 3000)
Tariff.create(name: "Командный зачет", people_number: 5, price: 5000)

puts 'destroying training programs...'
TrainingProgram.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('training_programs')
puts 'creating training programs...'
TrainingProgram.create(name: "Карьеристка")
TrainingProgram.create(name: "Беззаботная")
TrainingProgram.create(name: "Домохозяйка")

puts 'generating promocodes'
Rake::Task['promocodes:generate'].invoke(30)

