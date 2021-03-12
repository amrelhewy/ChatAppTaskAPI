class AddTokenNumberIndexToChat < ActiveRecord::Migration[6.0]
  def change
    add_index :chats, [:application_token, :number]
  end
end
