class CreateChats < ActiveRecord::Migration[6.0]
  def change
    create_table :chats do |t|
      t.string "application_token", :null => false
      t.integer :number

      t.timestamps
    end
    add_index :chats, :application_token
  end
end
