class SummariesController < ApplicationController
  before_action :authenticate_user!
	def create
		summary = current_user.summaries.create(summary_params)
		redirect_to :back
	end

	def update
		Summary.find(params[:id]).update(summary_params)
		redirect_to :back
	end

	private
	def summary_params
		params[:summary].permit(:weight, :height, :age, :chest, :waist, :thigh, :motivation)
	end
end