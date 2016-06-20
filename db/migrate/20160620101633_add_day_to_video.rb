class AddDayToVideo < ActiveRecord::Migration
  def change
    add_column :videos, :day, :integer
  end
end
