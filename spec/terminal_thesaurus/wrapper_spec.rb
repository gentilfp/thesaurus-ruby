require 'spec_helper'

RSpec.describe TerminalThesaurus::Wrapper do
  describe '#initialize' do
    subject { described_class.new(word) }
    let(:word) { 'after' }

    it 'initializes with nil values' do
      [:synonyms, :antonyms, :related].each do |attribute|
        expect(subject.send(attribute)).to be_nil
      end
    end

    it 'sets word attribute' do
      expect(subject.word).to eq word
    end
  end

  describe '#look_up' do
  end

end
