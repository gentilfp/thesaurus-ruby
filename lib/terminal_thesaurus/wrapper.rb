require 'open-uri'
require 'nokogiri'

module TerminalThesaurus
  class Wrapper
    attr_reader :word, :url, :synonyms, :antonyms, :type, :definition

    def initialize(word)
      @word = word
      @url = "http://www.thesaurus.com/browse/#{word}?s=t"
      @synonyms, @antonyms, @related = [], [], []
    end

    def look_up
      parse(Nokogiri::HTML(open(url)))
    rescue OpenURI::HTTPError
      "Cannot connect to thesaurus.com"
    end

    private
    def parse(page)
      # definition / type
      @type = page.css('.synonym-description .txt').first.text
      @definition = page.css('.synonym-description .ttl').first.text

      # synonyms
      page.css('.synonyms .relevancy-list ul').each do |column|
        column.css('li').each do |row|
          @synonyms << row.children[0].children[0].children[0].text
        end
      end

      # antonyms
      page.css('.antonyms .list-holder .list').each do |column|
        column.css('li').each do |row|
          @antonyms << row.children[0].children[0].children[0].text
        end
      end

      # related
      nil
    end
  end
end
