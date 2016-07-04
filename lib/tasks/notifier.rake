require 'open-uri'
task remind_pay: :environment do
  users = User.where(subscribed: true)
  count = users.count
  users.each_with_index do |user, i|
    UserMailer.pay_reminder_email(user).deliver_now
    puts "#{i+1}/#{count} done"
  end
end

namespace :notifier do
  desc "Send all email and sms, perform calls for all subscriptions"


  task notify_one_time: :environment do
    sts = SubscriptionType.one_time
    sts_count = sts.count
    sts.each_with_index do |st, i|
      succeed = 0
      subs = st.subscriptions
      subs_count = subs.count
      subs.each do |sub|
        res = sub.perform
        if res
          succeed += 1
        else
          puts "ERROR :: NOTIFIER one_time"
        end
      end
      st.update(active: false)
      puts "NOTIFIER one_time -> done #{i+1}/#{sts_count} (#{succeed}/#{subs_count} succeed)"
    end
  end

  task notify_periodic: :environment do
    sts = SubscriptionType.periodic
    sts_count = sts.count
    sts.each_with_index do |st, i|
      succeed = 0
      subs = st.subscriptions.where('last_notified_at IS NULL OR last_notified_at < ?', Time.now - st.periodicity.days)
      subs_count = subs.count
      subs.each do |sub|
        res = sub.perform
        if res
          succeed += 1
        else
          puts "ERROR :: NOTIFIER periodic"
        end
      end
      puts "NOTIFIER periodic -> done #{i+1}/#{sts_count} (#{succeed}/#{subs_count} succeed)"
    end
  end
end
