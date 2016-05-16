module API
  module ErrorFormatter
    def self.call message, backtrace, options, env
    	message = { en: message, ru: message } if message.is_a?(String)
      { status: 'error', message: message[:ru], en_message: message[:en] }.to_json
    end
  end
end
