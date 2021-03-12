class Chat < ApplicationRecord
  belongs_to :application, :foreign_key => "application_token", counter_cache: true
  validates :number, presence: true, uniqueness: { scope: :application_token }
  has_many :messages, dependent: :delete_all

  def add_chat_number
    max_number_per_token = Chat.where(application_token: self.application_token).maximum("number")
    if max_number_per_token.nil?
      self.number = 1
    else
      self.number = max_number_per_token + 1
    end
  end
end
