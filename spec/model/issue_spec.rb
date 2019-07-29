require 'rails_helper'

RSpec.describe Issue, type: :model do
  it "Issue登録ができる" do
    issue_valid = Issue.new(
      name: "テストネーム",
      about: "テストアバウト"
    )
    expect(issue_valid).to be_valid
  end

  context "nameがなかった場合" do
    it "Issue登録ができない" do
      issue_invalid = Issue.new(
        about: "テストアバウト"
      )
      expect(issue_invalid).not_to be_valid
    end
  end
end
