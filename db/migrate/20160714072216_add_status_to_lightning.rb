class AddStatusToLightning < ActiveRecord::Migration
  def change
    add_column :lightnings, :status, :integer
  end
end
