require 'open-uri'
namespace :promocodes do
  task :generate, [:number] => :environment do |t, args|
    n = args[:number].present? ? args[:number].to_i : 1
    n.times do
      code = loop do
        c = (1..7).map{rand(0..9).to_s}.join + ('a'..'z').to_a.sample
        break c unless Promocode.find_by(code: c)
      end
      Promocode.create(code: code)
    end
  end
end
