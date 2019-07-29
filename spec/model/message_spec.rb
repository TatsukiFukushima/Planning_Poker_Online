require 'rails_helper'

RSpec.describe Message, type: :model do
  let(:user) { FactoryBot.create(:user) }

  before do
    @room = Room.create(name: 'テストネーム', about: 'テストアバウト', created_user: user)
  end

  it 'Messageが送信できる' do
    message_valid = Message.new(content: 'テストメッセージでーす', sent_user: user, room_id: @room.id)
    expect(message_valid).to be_valid
  end

  context 'contentがなかった場合' do
    it 'Messageが送信出来ない' do
      message_invalid = Message.new(sent_user: user, room_id: @room.id)
      expect(message_invalid).not_to be_valid
    end
  end
end
