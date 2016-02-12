require 'rails_helper'

describe Project do
  it('has valid factory') { expect(build(:project)).to be_valid }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:user_id) }

  describe '#to_s' do
    let(:project) { create(:project, name: 'Awesome project') }

    it 'display name' do
      expect(project.to_s).to eq 'Awesome project'
    end
  end
end