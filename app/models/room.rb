class Room < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :room_issues, dependent: :destroy
  has_many :issues, through: :room_issues

  belongs_to :created_user, class_name: "User", foreign_key: 'user_id'

  validates :name, presence: true

end
