class Message < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  belongs_to :chat, counter_cache: true
  before_validation :add_message_number
  validates :body, :number, presence: true

  def self.search(query, chat_id)
    __elasticsearch__.search(
      {
        query: {
          "bool": {
            "must": [
              { "match": { "body": query } },
            ],
            "filter": [
              { "term": { "chat_id": chat_id } },
            ],
          },
        },
      }

    )
  end

  #select only the fields we need

  def as_indexed_json(options = nil)
    self.as_json(only: [:body, :chat_id, :number, :created_at])
  end

  def add_message_number
    maximum_number_message = Message.where(chat_id: self.chat_id).maximum("number")
    if maximum_number_message.nil?
      self.number = 1
    else
      self.number = maximum_number_message + 1
    end
  end
end
