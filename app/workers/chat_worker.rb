class ChatWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  sidekiq_options queue: "chat_queue"

  def perform(token)
    @chat = Chat.new(application_token: token)
    @chat.add_chat_number
    @chat.save
  end
end
