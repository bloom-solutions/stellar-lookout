class CreateReports < ActiveRecord::Migration[5.0]
  def change
    create_table :reports do |t|
      t.references :ward, foreign_key: true
      t.references :operation, foreign_key: true
      t.integer :status, null: false, default: 0
      t.timestamps
    end

    add_index :reports, [:ward_id, :operation_id], unique: true
  end
end
