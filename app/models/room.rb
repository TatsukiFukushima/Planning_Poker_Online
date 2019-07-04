class Room < ApplicationRecord
  has_many :messages
  belongs_to :created_user, class_name: "User", foreign_key: 'user_id'
end
