if Rails.env.test? || Rails.env.development?
  MessageBus.configure(backend: :memory)
else
  MessageBus.configure({
    backend: :postgres,
    backend_options: ENV["MESSAGE_BUS_PG_CONNECTION_STRING"],
    clear_every: 1_000,
  })

  MessageBus.configure(on_middleware_error: proc do |env, e|
    if Errno::EPIPE === e || Errno::ECONNRESET === e
      [422, {}, [""]]
    else
      raise e
    end
  end)

  MessageBus.reliable_pub_sub.max_backlog_age =
    ENV.fetch("MESSAGE_BUS_MAX_BACKLOG_AGE") { 5.days }.to_i

  MessageBus.reliable_pub_sub.max_backlog_size =
    ENV.fetch("MESSAGE_BUS_MAX_BACKLOG_SIZE") { 5_000 }.to_i

  MessageBus.reliable_pub_sub.max_global_backlog_size =
    ENV.fetch("MESSAGE_BUS_MAX_GLOBAL_BACKLOG_SIZE") { 30_000 }.to_i
end
