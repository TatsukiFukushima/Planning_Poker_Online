class RoomsController < ApplicationController
  before_action :correct_user, only: :destroy

  def new
    @room = Room.new
  end

  def show
    @room = Room.find(params[:id])
    @messages = @room.messages.includes(:sent_user)
  end

  def index
    @rooms = Room.all.includes(:created_user).order(created_at: :desc)
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

  def destroy
    @room.destroy
    flash[:success] = "部屋が削除されたぞ"
    redirect_to request.referrer || rooms_url
  end

  private
    def room_params
      params.require(:room).permit(:name, :about)
    end

    def correct_user
      @room = current_user.rooms.find_by(id: params[:id])
      redirect_to rooms_url if @room.nil?
    end

end
