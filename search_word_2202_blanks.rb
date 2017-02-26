# suggested by CC-discuss user ionatan
#  def searchword(trie, wildcards, tiles, output):
#    if trie is word:
#        output.append(trie.word) # or send current letters as arguments to this function
#
#   for each unique tile in tiles:
#      if trie has tile:
#         searchword(trie[tile], wildcards, (tiles - tile), output)
#
#   if wildcards > 0:
#      for each key in trie that has not already been searched in previous loop:
#         searchword(trie[key], (wildcards - 1), tiles, output)

require 'trie' 
require 'benchmark'
$counter = 0
trie = Trie.read("full_word_trie") #my instance of Trie structure
puts "Trie loaded."
input = %w[a b ?].sort
#inputs = [%w[a b c].sort, %w[? ?].sort, %w[a b c d e f g h i j k l m n o].sort, %w[d g ż b l o i ń ź a p l u r f].sort, %w[a b ż ź g ę f l j k p r t ś ?].sort, %w[a b c d e f g h i j k l m n ?].sort, %w[a b c d e f g h i j k l m ? ?].sort, %w[b c d g h j k l m n p r s ? ?].sort, %w[a i o e z n r w s t c y k].sort, %w[a i o e z n r w s t c y k ? ?].sort]
alphabet = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "r", "s", "t", "u", "w", "y", "z", "ó", "ą", "ć", "ę", "ł", "ń", "ś", "ź", "ż"]
#output = []
#wildcards = input.select{ |c| c=="?" }.size #count number of wildcards from user input
#input = input.join.gsub("?","").chars if wildcards > 0 # LAST CHANGES
def take_away(tiles, tile)
  #tiles.reject{ |t| tile.include? t } # rejects duplicates - need to fix
  if tile.is_a? Array
    tile.each{ |t| tiles.join.sub(t, "") }
    tiles #change from tiles.chars
  else
    tiles.join.sub(tile, "").chars
  end
end
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
    #for each key in trie that has not already been searched in previous loop:
   
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
#inputs.each do |input|
wildcards = input.select{ |c| c=="?" }.size
input = input.join.gsub("?","").chars if wildcards > 0
output = []
#search_word(trie.root, wildcards, alphabet, input, output)
puts Benchmark.measure { search_word(trie.root, wildcards, alphabet, input, output) } #my trie, starting point, number of wildcards, user input, empty output
puts "For input #{input} with #{wildcards} wildcards the output is:"
puts output.uniq.size
#puts "Function calls: #{$counter}"
#print output.first(200)
#end
