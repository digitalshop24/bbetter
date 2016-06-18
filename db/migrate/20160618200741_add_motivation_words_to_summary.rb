class AddMotivationWordsToSummary < ActiveRecord::Migration
  def change
    add_column :summaries, :motivation_words, :string
  end
end
