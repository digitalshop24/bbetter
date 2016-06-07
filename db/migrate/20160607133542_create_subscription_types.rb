class CreateSubscriptionTypes < ActiveRecord::Migration
  def change
    create_table :subscription_types do |t|
      t.string :name, null: false, index: true, unique: true
      t.string :key, null: false, index: true, unique: true
      t.boolean :active, null: false, default: true
      t.text :email_text
      t.text :sms_text
      t.text :phone_text
      t.float :periodicity, null: false, default: 0
    end
  end
end
