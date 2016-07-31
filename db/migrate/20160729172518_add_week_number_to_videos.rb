class AddWeekNumberToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :week, :integer
  end
end
