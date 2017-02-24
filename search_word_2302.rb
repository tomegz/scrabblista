require 'trie' 
require 'benchmark'
$counter = 0
tries = []
14.times{ |c| tries.push(Trie.read("tries/#{c}_letter_trie")) }
puts "Tries loaded"
# tries is an array of Tries - tries[0] - 2 letter - tries[13] - 15 letter.
input = %w[a b c d e f g h i j k l m ? ?].sort
alphabet = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "r", "s", "t", "u", "w", "y", "z", "ó", "ą", "ć", "ę", "ł", "ń", "ś", "ź", "ż"]
output = []
wildcards = input.select{ |c| c=="?" }.size #count number of wildcards from user input
input = input.join.gsub("?","").chars if wildcards > 0 # LAST CHANGES
#take_away needs to include polish letters!
def take_away(tiles, tile)
  #tiles.reject{ |t| tile.include? t } # rejects duplicates - need to fix
  if tile.is_a? Array
    tile.each{ |t| tiles.join.sub(t, "") }
    tiles #change from tiles.chars
  else
    tiles.join.sub(tile, "").chars
  end
end
#
def search_word(node, wildcards, alphabet, tiles, output)
  #puts "received call with node: #{node.full_state}, wildcards: #{wildcards}, tiles: #{tiles}"
  $counter += 1
  output.push(node.full_state) if node.terminal? # append output if its a word
  unless tiles.empty? && wildcards.zero?
    tiles.uniq.each do |tile|
      unless node.walk(tile).nil?
        next_node = node.walk(tile)
        remaining_tiles = take_away(tiles, tile)
        #puts "going with node: #{next_node.full_state} with tiles: #{remaining_tiles}"
        search_word(next_node, wildcards, alphabet, remaining_tiles, output) 
      end
    end
  end

  if wildcards > 0
    other_letters = take_away(alphabet, tiles.uniq)
    #puts "wildcards to use: #{other_letters}"
    other_letters.each do |tile|
      unless node.walk(tile).nil?
        #puts "trying wildcard: #{tile} on node #{node.full_state}"
        next_node = node.walk(tile)
        remaining_tiles = take_away(tiles, tile)
        remaining_wildcards = wildcards - 1
        search_word(next_node, remaining_wildcards, alphabet, tiles, output) 
      end
    end
  end

end

#search_word(trie.root, wildcards, alphabet, input, output)

14.times do |c|
puts "Found #{output.uniq.size} words"
puts Benchmark.measure { search_word(tries[c].root, wildcards, alphabet, input, output) } #my trie, starting point, number of wildcards, user input, empty output
puts "Function calls: #{$counter}"
end


