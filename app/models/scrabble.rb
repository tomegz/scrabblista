#require "string" or "ext/string" - not sure if needed
require 'trie'
class Scrabble

	include Alphabet # ALPHABET const - currently ASCII 8 BIT

	def initialize(trie, rack)
		@trie = trie
		@node = @trie.root
		@tiles = rack.tiles
		@alphabet = ALPHABET
		@wildcards = rack.wildcards
		@output = []
	end

	def find_words
		search_word(@node, @wildcards, @alphabet, @tiles, @output)
        @output.sort_by!(&:length).reverse!
    end

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
