require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'database' do
    context 'columns' do
      it { is_expected.to have_db_column(:name).of_type(:string).with_options(null: false) }
      it { is_expected.to have_db_column(:email).of_type(:string).with_options(null: false) }
      it { is_expected.to have_db_column(:fractal_id).of_type(:integer).with_options(null: false) }
      it { is_expected.to have_db_column(:token_dg).of_type(:string).with_options(null: false) }
      it { is_expected.to have_db_column(:photo_url).of_type(:string) }
      it { is_expected.to have_db_column(:status).of_type(:string).with_options(default: 'active') }
      it { is_expected.to have_db_column(:role).of_type(:string) }
    end

    context 'indexes' do
      it { is_expected.to have_db_index(:email).unique }
      it { is_expected.to have_db_index(:fractal_id).unique }
      it { is_expected.to have_db_index(:token_dg).unique }
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:app).inverse_of(:users) }
  end

  describe 'validations' do
    context 'presence' do
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_presence_of(:email) }
      it { is_expected.to validate_presence_of(:fractal_id) }
      it { is_expected.to validate_presence_of(:token_dg) }
    end

    context 'uniqueness' do
      subject { create(:user) }
      it { is_expected.to validate_uniqueness_of(:email) }
      it { is_expected.to validate_uniqueness_of(:fractal_id) }
      it { is_expected.to validate_uniqueness_of(:token_dg) }
    end
  end
end
