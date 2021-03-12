class CreateApplications < ActiveRecord::Migration[6.0]
  def change
    create_table :applications, id: false do |t|
      t.string :name
      t.string :token, :null => false, primary_key: true, :unique => true
      t.timestamps
    end
  end
end
