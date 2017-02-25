class WordController < ApplicationController
    require 'trie'
    @@trie = Trie.read("full_word_trie")
    @@alphabet = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "r", "s", "t", "u", "w", "y", "z", "ó", "ą", "ć", "ę", "ł", "ń", "ś", "ź", "ż"]

    def home
    end

    def search
      @input = params[:q].gsub(/\s+/, "").chars.sort # needs validations
      @wildcards = @input.select{ |c| c=="?" }.size
      @input = @input.join.gsub("?","").chars if wildcards > 0
      @output = []
      search_word(@@trie.root, @wildcards, @@alphabet, @input, @output)
    end
    
    # private methods

    private

    def take_away(tiles, tile)
      if tile.is_a? Array
        tile.each{ |t| tiles.join.sub(t, "") }
        tiles 
      else
        tiles.join.sub(tile, "").chars
      end
    end

    def search_word(node, wildcards, alphabet, tiles, output)
      @output = ["works", "hey"]
    end
end
