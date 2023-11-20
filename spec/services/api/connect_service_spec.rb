require 'rails_helper'

RSpec.describe Api::ConnectService do
  subject(:connect) { described_class.new(token:, url:).call }

  describe 'failure' do
    context 'token and url is nil' do
      let(:token) { nil }
      let(:url) { nil }

      it { expect(connect).to eq('Invalid params') }
    end

    context 'token is nil' do
      let(:token) { nil }
      let(:url) { 'http://www.google.com' }

      it { expect(connect).to eq('token can\'t be blank') }
    end

    context 'url is nil' do
      let(:token) { '123' }
      let(:url) { nil }

      it { expect(connect).to eq('url can\'t be blank') }
    end
  end

  describe 'successfully' do
    context 'token and url is present' do
      let(:token) { '123' }
      let(:url) { 'http://www.google.com' }

      it { expect(connect).to be_a(Faraday::Connection) }
    end
  end
end
