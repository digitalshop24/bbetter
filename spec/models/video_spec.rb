require 'rails_helper'

RSpec.describe Video, type: :model do
	it 'embed' do
		video = Video.new(youtube_code: 'HjsdnuwjU3j')
	end
end
