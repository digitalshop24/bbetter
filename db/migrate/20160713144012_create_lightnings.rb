class CreateLightnings < ActiveRecord::Migration
  def change
    create_table :lightnings do |t|
      t.text :message

      t.timestamps null: false
    end
  end
end
