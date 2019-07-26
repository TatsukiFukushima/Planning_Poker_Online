class RoomIssuesController < ApplicationController
  def edit
    session[:forwarding_url] = request.original_url if request.get?
    @room = Room.find(params[:id])
    @issues = Kaminari.paginate_array(Issue.all.order(created_at: :desc)).page(params[:page]).per(5)
  end

  def create
    @issue = Issue.find(params[:issue_id])
    @room = Room.find(params[:room_id])
    RoomIssue.create(room_id: @room.id, issue_id: params[:issue_id])
  end

  def destroy
    @issue = Issue.find(params[:issue_id])
    @room = Room.find(params[:room_id])
    RoomIssue.find_by(room_id: @room.id, issue_id: params[:issue_id]).destroy
  end
end
