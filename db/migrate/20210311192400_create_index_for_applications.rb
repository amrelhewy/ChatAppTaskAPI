class CreateIndexForApplications < ActiveRecord::Migration[6.0]
  def change
    add_index :applications, :token
  end
end
