class VideoChanges < ActiveRecord::Migration
  def change
    rename_column :videos, :youtube_code, :link
  end
end
