require 'rails_helper'
describe 'Galleries API' do
  context 'POST /api/v1/galleries' do
    it 'not authorized' do
      delete "/api/v1/galleries/46832"
      expect(response.status).to eq(401)
    end
  end
  context 'DELETE /api/v1/galleries/:gallery_id' do
    it 'not found' do
      user = User.create(email: 'email@site.ru', password: '12345678')
      delete "/api/v1/galleries/46832", nil, { 'Auth-Token' => user.auth_token }
      expect(response.status).to eq(404)
    end
  end
end
