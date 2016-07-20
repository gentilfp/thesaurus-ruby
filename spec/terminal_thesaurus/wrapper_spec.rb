require 'spec_helper'

RSpec.describe TerminalThesaurus::Wrapper do
  describe '#initialize' do
    subject { described_class.new(word) }
    let(:word) { 'after' }

    it 'initializes with empty values' do
      [:synonyms, :antonyms, :related].each do |attribute|
        expect(subject.send(attribute)).to be_empty
      end
    end

    it 'sets word attribute' do
      expect(subject.word).to eq word
    end
  end

  describe '#look_up' do
    subject { described_class.new('beautiful') }
    let(:url) { "http://www.thesaurus.com/browse/beautiful?s=t" }
    after { subject.look_up }

    context 'success' do
      it 'parses synonyms and antonyms' do
        stub_request(:any, url).to_return(body: 'nokogiri')
        expect(subject).to receive(:parse).with(anything)
      end
    end

    context 'failure' do
      it 'catches exception and returns a message' do
        stub_request(:any, url).to_raise(OpenURI::HTTPError.new('', nil))
        expect(subject).to_not receive(:parse)
      end
    end
  end

end
