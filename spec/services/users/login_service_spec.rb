# frozen_string_literal: true

require 'rails_helper'
require 'webmock/rspec'

RSpec.describe Users::LoginService do
  subject(:login) { described_class.new(token:, dg_user:).call }

  describe '#call' do
    describe 'failure' do
      context 'token and dg_user is nil' do
        let(:token) { nil }
        let(:dg_user) { nil }

        it { expect(login).to be_falsey }
      end

      context 'token and dg_user is blank' do
        let(:token) { '' }
        let(:dg_user) { '' }

        it { expect(login).to be_falsey }
      end
    end

    describe 'successfully' do
      context 'when user is present' do
        let(:token) { 'valid_token' }
        let(:dg_user) { create(:user) }

        it 'returns token' do
          expect(login).to be_present
        end
      end

      context 'when user is not present' do
        let(:token) { 'valid_token' }
        let(:dg_user) { attributes_for(:user) }

        it 'returns token' do
          expect(login).to be_present
        end
      end
    end
  end
end
