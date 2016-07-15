module TerminalThesaurus
  class Wrapper
    attr_reader :word, :synonyms, :antonyms, :related

    def initialize(word)
      @word = word
      @synonyms, @antonyms, @related = nil
    end

    def look_up
    end
  end
end
