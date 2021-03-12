class ChangeTexttoBodyinMessage < ActiveRecord::Migration[6.0]
  def change
    change_column :messages, :text, :text
    rename_column :messages, :text, :body
  end
end
