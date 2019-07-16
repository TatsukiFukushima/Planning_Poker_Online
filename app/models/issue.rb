class Issue < ApplicationRecord
  has_many :room_issues
  has_many :rooms, through: :room_issues

  def index
  end

  def tied?(room)
    room.issues.include?(self)
  end
end
