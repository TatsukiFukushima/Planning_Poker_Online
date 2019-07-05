class RoomsController < ApplicationController

  def new
    @room = Room.new
  end

  def show
    @room = Room.find(params[:id])
    @messages = @room.messages.includes(:sent_user)
  end

  def index
    @rooms = Room.all.order(:id)
  end

  def create
    @room = Room.new(room_params)
    @room.user_id = current_user.id
    if @room.save
      flash[:success] = "部屋を作成したぞ"
      redirect_to rooms_url
    else
      render 'new'
    end
  end

  private
    def room_params
      params.require(:room).permit(:name, :about)
    end

end
