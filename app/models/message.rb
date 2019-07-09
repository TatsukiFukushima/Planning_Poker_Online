class Message < ApplicationRecord
  validates :content, presence: true

  belongs_to :sent_user, class_name: "User", foreign_key: 'user_id'
  belongs_to :room

  after_create_commit { MessageBroadcastJob.perform_later self }
end
