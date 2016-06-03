class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.references :gallery, index: true, foreign_key: true
      t.attachment :image
      t.string :image_type

      t.timestamps null: false
    end
  end
end
