class MesageWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  sidekiq_options queue: "message_queue"

  def perform(chat_id, body)
    @message = Message.new(chat_id: chat_id, body: body)
    @message.save
  end
end
