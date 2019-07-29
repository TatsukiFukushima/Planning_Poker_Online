require 'rails_helper'

RSpec.describe Room, type: :model do
  let(:user) { User.new(name: 'テスト太郎') }

  before do
    user
  end

  it 'Roomが登録できる' do
    room_valid = Room.new(name: 'テストネーム', about: 'テストアバウト', created_user: user)
    expect(room_valid).to be_valid
  end

  context 'nameがなかった場合' do
    it 'Room登録が出来ない' do
      room_invalid = Room.new(about: 'テストアバウト', created_user: user)
      expect(room_invalid).not_to be_valid
    end
  end
end
