class Report < ActiveRecord::Base

  belongs_to :operation
  belongs_to :ward

  has_many :report_responses, dependent: :destroy

  enum status: {
    error: -1,
    pending: 0,
    complete: 1,
  }

end
