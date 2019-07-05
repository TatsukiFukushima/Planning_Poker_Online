class Room < ApplicationRecord
  has_many :messages, dependent: :destroy
  belongs_to :created_user, class_name: "User", foreign_key: 'user_id'

  validates :name, presence: true

end
