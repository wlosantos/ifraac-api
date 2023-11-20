# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::AccountService do
  subject(:account_service) { described_class.new(token).call }

  describe '#call' do
    describe 'failure' do
      context 'token is nil' do
        let(:token) { nil }

        it { expect(account_service).to be_falsey }
      end

      context 'token is blank' do
        let(:token) { '' }

        it { expect(account_service).to be_falsey }
      end

      context 'token is invalid' do
        let(:token) { 'invalid_token' }

        it { expect(account_service).to be_falsey }
      end
    end

    describe 'successfully' do
      let(:user)  { create(:user) }
      let(:token) { user.token_dg }

      it { expect(account_service).to be_a(String) }
    end
  end
end
