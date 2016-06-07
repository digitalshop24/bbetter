class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :user, index: true, foreign_key: true
      t.text :text
      t.integer :message_type, null: false, default: 0

      t.timestamps null: false
    end
  end
end
