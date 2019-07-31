class Issue < ApplicationRecord
  has_many :room_issues, dependent: :destroy
  has_many :rooms, through: :room_issues

  validates :name, presence: true, uniqueness: true

  def tied?(room)
    room.issues.include?(self)
  end
end
