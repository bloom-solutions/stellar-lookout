class AddReportsStatusIndex < ActiveRecord::Migration[5.0]
  def change
    add_index :reports, :status
  end
end
