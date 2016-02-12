require 'rails_helper'

describe User do
  it('has valid factory') { expect(build(:user)).to be_valid }

  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }

  describe '#projects_for_display' do
    let(:user) { create(:user) }
    let(:user2) { create(:user) }

    before do
      create(:project, name: 'pr1', user: user)
      create(:project, name: 'pr2', user: user)
      create(:project, name: 'pr3', user: user2)
    end

    it 'displays projects names' do
      expect(user.projects_for_display).to eq 'pr1, pr2'
    end
  end

  describe '#to_s' do
    let(:user) { create(:user, first_name: 'Monika', last_name: 'Skrobis') }

    it 'display first name with last name' do
      expect(user.to_s).to eq 'Monika Skrobis'
    end
  end
end