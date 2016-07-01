class AddColsToUser < ActiveRecord::Migration
  def change
    add_column :users, :moto, :string
    add_column :users, :phone, :string
  end
end
