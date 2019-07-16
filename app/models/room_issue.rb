class RoomIssue < ApplicationRecord
  belongs_to :room
  belongs_to :issue
end
