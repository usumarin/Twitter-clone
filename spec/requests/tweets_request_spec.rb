require 'rails_helper'
require 'spec_helper'

RSpec.describe "Tweets", type: :request do

  describe 'tweets#create' do
    it 'リクエストが成功すること' do
      get new_path
      expect(response.status).to eq 200
    end

    it 'フォームが表示されていること' do
      get new_path
      expect(response.body).to include "tweet-form"
    end
  end
end
