require 'rails_helper'

RSpec.describe Taggable, type: :model do
  describe 'associations' do
    it 'belongs to a post' do
      association = described_class.reflect_on_association(:post)
      expect(association.macro).to eq(:belongs_to)
    end

    it 'belongs to a tag' do
      association = described_class.reflect_on_association(:tag)
      expect(association.macro).to eq(:belongs_to)
    end
  end
end
