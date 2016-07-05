class AddReferrerToPromocode < ActiveRecord::Migration
  def change
    add_column :promocodes, :referrer_id, :integer
    add_foreign_key :promocodes, :users, column: :referrer_id
  end
end
