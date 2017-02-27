require 'trie'
class WordController < ApplicationController

    @@trie = Trie.read("tries/full_word_trie")
    
    def home
    end

    def search
      @rack = Tile.new(params[:q])
      @scrabble = Scrabble.new(@@trie, @rack)
      @words = @scrabble.find_words
    end
    
end
