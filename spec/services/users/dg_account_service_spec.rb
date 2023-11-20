# frozen_string_literal: true

require 'rails_helper'
require 'webmock/rspec'

RSpec.describe Users::DgAccountService do
  subject(:dg_account) { described_class.new(token:, url:).call }

  describe '#call' do
    describe 'failure' do
      context 'token is nil' do
        let(:token) { nil }
        let(:url)   { nil }

        it { expect(dg_account).to be_falsey }
      end

      context 'token is invalid' do
        let(:token) { 'invalid_token' }
        let(:url)   { 'http://api.test.com' }

        it 'returns error message and status code 401' do
          stub_request(:post, 'http://api.test.com/api/v1/users/check')
            .to_return(status: 401, body: { message: 'Access denied' }.to_json, headers: {})

          expect(dg_account.body).to include('Access denied')
          expect(dg_account.status).to eq(401)
        end
      end
    end

    describe 'successfully' do
      context 'returns data' do
        let(:token) { 'valid_token' }
        let(:url)   { 'http://api.test.com' }

        it 'returns data and status code 200' do
          stub_request(:post, 'http://api.test.com/api/v1/users/check')
            .to_return(status: 200, body: { data: { id: 1, name: 'test' } }.to_json, headers: {})

          expect(dg_account.body).to include('data')
          expect(dg_account.status).to eq(200)
        end
      end
    end
  end
end
