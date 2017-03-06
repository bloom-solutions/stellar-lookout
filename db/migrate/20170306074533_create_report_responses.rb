class CreateReportResponses < ActiveRecord::Migration[5.0]
  def change
    create_table :report_responses do |t|
      t.references :report, foreign_key: true
      t.text :body
      t.integer :status_code, index: true
    end
  end
end
