class Video < ActiveRecord::Base
  VIDEO_SIZES = { width: 300, height: 200 }
  YOUTUBE_REGEX = /^(?:http(?:s)?:\/\/)?(?:www\.)?(?:m\.)?(?:youtu\.be\/|youtube\.com\/(?:(?:watch)?\?(?:.*&)?v(?:i)?=|(?:embed|v|vi|user)\/))([^\?&\"'>]+)/
  
  belongs_to :user
  validates_presence_of :link

  def iframe sizes = VIDEO_SIZES
    if youtube_code
      code = "<iframe width=\"#{sizes[:width]}\" height=\"#{sizes[:height]}\" src=\"https://www.youtube.com/embed/#{youtube_code}\" frameborder=\"0\" allowfullscreen></iframe>"
      code.html_safe
    end
  end

  def youtube_code
    link.scan(YOUTUBE_REGEX).flatten.first if link
  end

  rails_admin do
    edit do
      field :link
      field :day
      field :user
    end
    show do
      field :video_iframe
      field :day
      field :user
      field :created_at
    end
    list do
      field :id
      field :video_iframe
      field :user
      field :created_at
    end
  end
end
