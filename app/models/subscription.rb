class Subscription < ActiveRecord::Base
  TEXT_REPLACEMENTS = %w(name email city age motivation)
  enum channel: { sms: 'sms', email: 'email', phone: 'phone' }

  belongs_to :user
  belongs_to :subscription_type

  validates :user, :subscription_type, :channel, presence: true
  validates_uniqueness_of :subscription_type, scope: [:user, :channel]

  def perform
    text = subscription_type["#{channel}_text".to_sym]
    status = "#{channel.capitalize}Sender".constantize.new(user, text).perform
    if status
      update!(last_notified_at: Time.now)
    end
  end

  def channel_enum
    Subscription.channels.keys
  end
end

class Notifier
  def generate_message user, text
    Subscription::TEXT_REPLACEMENTS.each do |tr|
      text.gsub!("%user_#{tr}%", user.send(tr.to_sym).to_s)
    end
    text
  end
end

class EmailSender < Notifier
  def initialize user, text
    @email = user.email
    @message = generate_message(user, text).scan(/%email_body%([\s\S.]+)%email_body%/).flatten.first.gsub(/\n/, '')
    @subject = generate_message(user, text).scan(/%email_subject%([\s\S.]+)%email_subject%/).flatten.first
  end
  def perform
    UserMailer.subscription_email(@email, @message, @subject).deliver_now
  end
end

class SmsSender < Notifier
  def initialize user, text
    # @phone = user.phone
    @message = generate_message(user, text)
  end
  def perform
    # Twilio
    true
  end
end

class PhoneCaller < Notifier
  def initialize user, text
    # @phone = user.phone
    @message = generate_message(user, text)
  end
  def perform
    # Twilio
    true
  end
end
