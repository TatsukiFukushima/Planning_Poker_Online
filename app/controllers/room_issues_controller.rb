class RoomIssuesController < ApplicationController
  def edit
    @room = Room.find(params[:id])
    @issues = Issue.all.order(created_at: :desc)
  end

  def create
    @room = Room.find(params[:room_id])
    RoomIssue.create(room_id: @room.id, issue_id: params[:issue_id])
    redirect_to @room
  end
end
