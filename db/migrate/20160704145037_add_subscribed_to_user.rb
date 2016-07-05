class AddSubscribedToUser < ActiveRecord::Migration
  def change
    add_column :users, :subscribed, :boolean, null: false, default: true
  end
end
