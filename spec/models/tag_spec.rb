require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe 'associations' do
    it 'has many taggables' do
      association = described_class.reflect_on_association(:taggables)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:dependent]).to eq(:destroy)
    end

    it 'has many posts through taggables' do
      association = described_class.reflect_on_association(:posts)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:through]).to eq(:taggables)
    end
  end

  describe 'validations' do
    it 'is valid with a name' do
      tag = Tag.new(name: 'Example Tag')
      expect(tag).to be_valid
    end

    it 'is not valid without a name' do
      tag = Tag.new
      expect(tag).not_to be_valid
      expect(tag.errors[:name]).to include("can't be blank")
    end
  end
end
