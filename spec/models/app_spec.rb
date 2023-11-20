require 'rails_helper'

RSpec.describe App, type: :model do
  describe 'database' do
    context 'columns' do
      it { is_expected.to have_db_column(:name).of_type(:string).with_options(null: false) }
      it { is_expected.to have_db_column(:dg_app_id).of_type(:integer).with_options(null: false) }
    end

    context 'indexes' do
      it { is_expected.to have_db_index(:dg_app_id).unique }
    end
  end

  describe 'associations' do
    it { is_expected.to have_many(:users).dependent(:destroy) }
  end

  describe 'validations' do
    context 'presence' do
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_presence_of(:dg_app_id) }
    end

    context 'uniqueness' do
      subject { create(:app) }
      it { is_expected.to validate_uniqueness_of(:dg_app_id) }
    end
  end
end
