class RoomsController < ApplicationController

  def show
    @room = Room.find(params[:id])
    @messages = @room.messages
  end

  def index
    @rooms = Room.all.order(:id)
  end

end
