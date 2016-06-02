class CreateUserTariffs < ActiveRecord::Migration
  def change
    create_table :user_tariffs do |t|
      t.references :user, index: true, foreign_key: true
      t.references :tariff, index: true, foreign_key: true
      t.integer :status, null: false, default: 0

      t.timestamps null: false
    end
  end
end
