#require "string" or "ext/string" - not sure if needed
require 'trie'
class Scrabble

	include Alphabet # ALPHABET, P_LETTERS

	def initialize(trie, rack)
		@trie = trie
		@node = @trie.root
		@tiles = rack.tiles
		@alphabet = ALPHABET
		@wildcards = rack.wildcards
		@output = []
	end

	def find_words
		search_word(@trie, @node, @wildcards, @alphabet, @tiles, @output)
    @output.sort_by!{ |w| w.content.length }.reverse!
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

    def normalize(word)
      normalized = word
      P_LETTERS_MIRROR.each do |key, value| 
        normalized = normalized.gsub(key, value)
      end
      normalized
    end

	def search_word(trie, node, wildcards, alphabet, tiles, output)
      output.push( Word.new( normalize(node.full_state), trie.get(node.full_state) ) ) if node.terminal? 
      unless tiles.empty? && wildcards.zero?
        tiles.uniq.each do |tile|
          unless node.walk(tile).nil?
            next_node = node.walk(tile)
            remaining_tiles = take_away(tiles, tile)
            search_word(trie, next_node, wildcards, alphabet, remaining_tiles, output) 
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
            search_word(trie, next_node, remaining_wildcards, alphabet, tiles, output) 
          end
        end
      end
    end

end
