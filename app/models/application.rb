class Application < ApplicationRecord
  has_secure_token
  validates :name, presence: true, uniqueness: true
  has_many :chats, :primary_key => "token", :foreign_key => "application_token", dependent: :delete_all
end
