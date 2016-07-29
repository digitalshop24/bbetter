class VideosController < ApplicationController
  before_action :authenticate_user!
  def create
    video = Video.create(video_params.merge(user: current_user))
    if video.errors.present?
      render json: { status: 'error', errors: video.errors }
    else
      render json: { status: 'ok', message: 'Ваше видео добавлено' }
    end
  end

  private
  def video_params
    params[:video].permit(:link, :week)
  end
end
