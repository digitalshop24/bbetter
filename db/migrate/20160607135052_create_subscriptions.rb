class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.references :user, index: true, foreign_key: true
      t.references :subscription_type, index: true, foreign_key: true
      t.datetime :last_notified_at

      t.timestamps null: false
    end
    add_column :subscriptions, :channel, :channel, null: false
    add_index :subscriptions, [:user_id, :subscription_type_id, :channel], unique: true, name: 'index_subscriptions_user_subscription_type_channel'
  end
end
