class CreateTrainingPrograms < ActiveRecord::Migration
  def change
    create_table :training_programs do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
