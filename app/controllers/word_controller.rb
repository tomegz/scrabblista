class WordController < ApplicationController
    require 'trie'
    @@trie = Trie.read("tries/full_word_trie")
    #@@alphabet = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "r", "s", "t", "u", "w", "y", "z", "ó", "ą", "ć", "ę", "ł", "ń", "ś", "ź", "ż"]

    def home
      #@trie |= Trie.read("tries/full_word_trie") # possibly move up as @@
    end

    def search
      @tiles = Tile.new(params[:q])
      @scrabble = Scrabble.new(@@trie, @tiles)
      @words = @scrabble.find_words
    end
    
    
end
