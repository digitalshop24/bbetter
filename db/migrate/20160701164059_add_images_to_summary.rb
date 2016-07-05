class AddImagesToSummary < ActiveRecord::Migration
  def change
  	remove_attachment :summaries, :before
  	remove_attachment :summaries, :after
  	add_attachment :summaries, :before_front
  	add_attachment :summaries, :before_back
  	add_attachment :summaries, :before_left
  	add_attachment :summaries, :before_right
  	add_attachment :summaries, :after_front
  	add_attachment :summaries, :after_back
  end
end
