class EnqueueProcessLedgers

  extend LightService::Action
  expects :paging_token

  executed do |c|
    ProcessLedgersJob.perform_later(c.paging_token)
  end

end
