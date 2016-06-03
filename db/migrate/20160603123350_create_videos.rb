class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :youtube_code
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
