class CreateSummaries < ActiveRecord::Migration
  def change
    create_table :summaries do |t|
      t.references :user, index: true, foreign_key: true
      t.attachment :before
      t.attachment :after
      t.attachment :motivation
      t.integer :weight
      t.integer :height
      t.integer :age
      t.integer :chest
      t.integer :waist
      t.integer :thigh

      t.timestamps null: false
    end
  end
end
