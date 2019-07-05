class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel_#{params['room_id']}"
  end

  def unsubscribed
    subscription = Subscription.find_by(user_id: current_user.id, room_id: params['room_id'])
    subscription.destroy
  end

  def speak(data)
    Message.create!(content: data['message'], user_id: current_user.id, room_id: params['room_id'])
  end
end
