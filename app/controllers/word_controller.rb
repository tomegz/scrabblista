class WordController < ApplicationController
    require 'trie'
    @@trie = Trie.read("tries/full_word_trie")
    @@alphabet = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "r", "s", "t", "u", "w", "y", "z", "ó", "ą", "ć", "ę", "ł", "ń", "ś", "ź", "ż"]

    def home
    end

    def search
      @input = params[:q].gsub(/\s+/, "").chars.sort # needs validations
      @wildcards = @input.select{ |c| c=="?" }.size
      @input = @input.join.gsub("?","").chars if @wildcards > 0
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
      output.push(node.full_state) if node.terminal? 
      unless tiles.empty? && wildcards.zero?
        tiles.uniq.each do |tile|
          unless node.walk(tile).nil?
            next_node = node.walk(tile)
            remaining_tiles = take_away(tiles, tile)
            search_word(next_node, wildcards, alphabet, remaining_tiles, output) 
          end
        end
      end
      #for each key in trie that has not already been searched in previous loop:
      if wildcards > 0
        other_letters = take_away(alphabet, tiles.uniq)
        other_letters.each do |tile|
          unless node.walk(tile).nil?
            next_node = node.walk(tile)
            remaining_tiles = take_away(tiles, tile)
            remaining_wildcards = wildcards - 1
            search_word(next_node, remaining_wildcards, alphabet, tiles, output) 
          end
        end
      end
    end
    
end
