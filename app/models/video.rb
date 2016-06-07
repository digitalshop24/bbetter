class Video < ActiveRecord::Base
  VIDEO_SIZES = { width: 300, height: 200 }
  belongs_to :user

  def video sizes = VIDEO_SIZES
    code = "<iframe width=\"#{sizes[:width]}\" height=\"#{sizes[:height]}\" src=\"https://www.youtube.com/embed/#{youtube_code}\" frameborder=\"0\" allowfullscreen></iframe>"
  	code.html_safe
  end

  rails_admin do
    edit do
      field :youtube_code
      field :user
    end
    show do
      field :video
      field :user
      field :created_at
    end
    list do
      field :id
      field :video
      field :user
      field :created_at
    end
  end
end
