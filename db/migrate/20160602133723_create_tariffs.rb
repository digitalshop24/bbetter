class CreateTariffs < ActiveRecord::Migration
  def change
    create_table :tariffs do |t|
      t.string :name
      t.integer :price
      t.integer :people_number
      t.text :short_content
      t.text :full_content
      t.attachment :image
      t.attachment :additional_image

      t.timestamps null: false
    end
  end
end
