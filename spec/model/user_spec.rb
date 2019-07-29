require 'rails_helper'

RSpec.describe User, type: :model do
  it "ユーザー登録ができる" do
    user_valid = User.new(
      name: "テストネーム",
      email: "test@example.com",
      password: "password",
      password_confirmation: "password"
    )
    expect(user_valid).to be_valid
  end

  context "パスワードが間違っていた場合" do
    it "ユーザー登録が出来ない" do
      user_invalid = User.new(
        name: "テストネーム",
        email: "test@example.com",
        password: "password",
        password_confirmation: "hogehoge"
      )
      expect(user_invalid).not_to be_valid
    end
  end
end
