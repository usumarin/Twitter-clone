require 'rails_helper'

RSpec.describe Tweet, type: :model do

  it "入力がある場合は有効である" do
    tweet = Tweet.new(content: "test")
    expect(tweet).to be_valid
  end

  it "入力がない場合は無効である" do
    tweet = Tweet.new(content: "")
    expect(tweet).not_to be_valid
  end

  it "入力が140字以内の場合は有効である" do
    tweet = Tweet.new(content: "a" * 140)
    expect(tweet).to be_valid
  end
  it "入力が141字以上の場合は無効である" do
    tweet = Tweet.new(content: "a" * 141)
    expect(tweet).not_to be_valid
  end
end
