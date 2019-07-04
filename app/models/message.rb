class Message < ApplicationRecord
  validates :content, presence: true
  after_create_commit { MessageBroadcastJob.perform_later self }

  belongs_to :sent_user, class_name: "User", foreign_key: 'user_id'
  belongs_to :room
end
