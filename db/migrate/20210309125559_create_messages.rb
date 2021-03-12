class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.integer :number
      t.string :text
      t.references :chat
      t.timestamps
    end
  end
end
