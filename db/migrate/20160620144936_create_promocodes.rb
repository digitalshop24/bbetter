class CreatePromocodes < ActiveRecord::Migration
  def change
    create_table :promocodes do |t|
      t.string :code, null: false, unique: true
      t.references :user, index: true, foreign_key: true
      t.datetime :activated_at

      t.timestamps null: false
    end
  end
end
