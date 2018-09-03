class DropReportResponses < ActiveRecord::Migration[5.2]
  def change
    drop_table "report_responses" do |t|
      t.integer "report_id"
      t.text "body"
      t.integer "status_code"
      t.index ["report_id"], name: "index_report_responses_on_report_id"
      t.index ["status_code"], name: "index_report_responses_on_status_code"
    end
  end
end
