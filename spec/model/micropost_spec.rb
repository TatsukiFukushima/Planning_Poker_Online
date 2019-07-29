require 'rails_helper'

RSpec.describe Micropost, type: :model do
  let(:user) { FactoryBot.create(:user) }

  it 'Micropostが登録できる' do
    micropost_valid = Micropost.new(content: 'テスト投稿でーす', user_id: user.id)
    expect(micropost_valid).to be_valid
  end

  context 'contentがなかった場合' do
    it 'Micropost登録が出来ない' do
      micropost_invalid = Micropost.new(user_id: user.id)
      expect(micropost_invalid).not_to be_valid
    end
  end
end
