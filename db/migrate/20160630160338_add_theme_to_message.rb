class AddThemeToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :theme, :string
  end
end
