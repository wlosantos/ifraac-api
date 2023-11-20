require 'rails_helper'
require 'webmock/rspec'

RSpec.describe Api::AuthService do
  subject(:auth) { described_class.new(token:, url:).call }

  describe 'failure' do
    context 'token and url is nil' do
      let(:token) { nil }
      let(:url) { nil }

      it { expect(auth).to eq('Invalid params') }
    end

    context 'token is invalid' do
      let(:token) { '123' }
      let(:url) { 'http://api.test_dg.com' }

      it 'returns error message and status code 401' do
        stub_request(:post, 'http://api.test_dg.com/api/v1/users/check')
          .to_return(status: 401, body: { message: 'Access denied' }.to_json, headers: {})

        expect(auth.body).to include('Access denied')
        expect(auth.status).to eq(401)
      end
    end
  end

  describe 'successfully' do
    context 'returns data' do
      let(:token) { '123' }
      let(:url) { 'http://api.test_dg.com' }

      it 'returns data and status code 200' do
        stub_request(:post, 'http://api.test_dg.com/api/v1/users/check')
          .to_return(status: 200, body: { data: { id: 1, name: 'test' } }.to_json, headers: {})

        expect(auth.body).to include('data')
        expect(auth.status).to eq(200)
      end
    end
  end
end
