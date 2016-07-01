class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.string :name
      t.string :email
      t.string :theme
      t.text :message
      t.string :sender_type

      t.timestamps null: false
    end
  end
end
