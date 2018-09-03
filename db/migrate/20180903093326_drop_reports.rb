class DropReports < ActiveRecord::Migration[5.2]
  def change
    drop_table "reports" do |t|
      t.integer "ward_id"
      t.integer "operation_id"
      t.integer "status", default: 0, null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["operation_id"], name: "index_reports_on_operation_id"
      t.index ["status"], name: "index_reports_on_status"
      t.index ["ward_id", "operation_id"], name: "index_reports_on_ward_id_and_operation_id", unique: true
      t.index ["ward_id"], name: "index_reports_on_ward_id"
    end
  end
end
