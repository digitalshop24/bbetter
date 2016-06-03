require 'rails_helper'
describe 'Videos API' do
  before(:each) do
    @user = User.create(email: 'user@mail.ru', password: 'password')
  end
  context 'GET /api/v1/videos' do
    it 'unauthorized' do
      get "/api/v1/videos", nil, { 'Auth-Token' => 'asdasdasdqwad' }
      expect(response.status).to eq(401)
    end
    it 'videos list' do
      v1 = @user.videos.create(youtube_code: 'Jsa21jnasdk')
      v2 = @user.videos.create(youtube_code: 'hyAvhg2HHaa')
      get "/api/v1/videos", nil, { 'Auth-Token' => @user.auth_token }
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)).to eq({items: [{id: v1.id, youtube_code: 'Jsa21jnasdk'}, {id: v2.id, youtube_code: 'hyAvhg2HHaa'}]}.deep_stringify_keys)
    end
  end
  context 'POST /api/v1/videos' do
    it 'unauthorized' do
      post "/api/v1/videos", nil, { 'Auth-Token' => 'asdasdasdqwad' }
      expect(response.status).to eq(401)
    end
    it 'regexp validation failed' do
      youtube_code = 'asWsdas3qwwr'
      post "/api/v1/videos", { youtube_code: youtube_code}, { 'Auth-Token' => @user.auth_token }
      expect(JSON.parse(response.body)['message']).to eq('youtube_code is invalid')
      expect(response.status).to eq(500)
      expect(JSON.parse(response.body)['status']).to eq('error')

      youtube_code = 'aAw23%sadwq'
      post "/api/v1/videos", { youtube_code: youtube_code}, { 'Auth-Token' => @user.auth_token }
      expect(JSON.parse(response.body)['message']).to eq('youtube_code is invalid')
      expect(response.status).to eq(500)
      expect(JSON.parse(response.body)['status']).to eq('error')
    end
    it 'creating video' do
      youtube_code = 'asWsdas3qww'
      post "/api/v1/videos", { youtube_code: youtube_code}, { 'Auth-Token' => @user.auth_token }
      res = {status: 'ok', item: {youtube_code: youtube_code}}
      json = JSON.parse(response.body)
      expect(response.status).to eq(201)
      expect(json['status']).to eq('ok')
      expect(json['item']['youtube_code']).to eq(youtube_code)
    end
  end
  context 'DELETE /api/v1/videos/:video_id' do
    it 'success deleting' do
      video_id = @user.videos.create(youtube_code: 'Jsa21jnasdk').id
      delete "/api/v1/videos/#{video_id}", nil, { 'Auth-Token' => @user.auth_token }
      expect(Video.find_by_youtube_code('Jsa21jnasdk')).to be_nil
      expect(JSON.parse(response.body)['status']).to eq('ok')
    end
    it 'not found' do
      delete "/api/v1/videos/324", nil, { 'Auth-Token' => @user.auth_token }
      expect(response.status).to eq(404)
    end
  end
end
