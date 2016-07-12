class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :title
      t.belongs_to :user, index: true
      t.timestamps null: false
    end
    change_table :posts do |t|
      t.belongs_to :topic, index: true
    end
  end
end
