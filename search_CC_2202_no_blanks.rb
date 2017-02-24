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

trie = Trie.read("full_word_trie") #my instance of Trie structure
puts "Trie loaded."
input = %w[a a g u w].sort
output = []
wildcards = input.select{ |c| c=="?" }.size #count number of wildcards from user input
def take_away(tiles, tile)
  tiles.join.sub(tile, "").chars
end
def search_word(node, wildcards, tiles, output)
  puts "Received param: node #{node.full_state}, tiles to iterate: #{tiles}"
  output.push(node.full_state) if node.terminal? # append output if its a word
  unless tiles.empty?
    tiles.uniq.each do |tile|
  	  puts "iterating over tiles #{tiles} current tile: #{tile} im on node: #{node.full_state}"
  	  unless node.walk(tile).nil?
  	    next_node = node.walk(tile)
  	    remaining_tiles = take_away(tiles, tile)
  	    puts "sending new node: #{next_node.full_state} with tiles: #{remaining_tiles}"
  	    puts "node is #{node.full_state} next node is #{next_node.full_state}"
  	    search_word(next_node, wildcards, remaining_tiles, output) 
  	  end
    end
  end
end

search_word(trie.root, wildcards, input, output)
#puts Benchmark.measure{ search_word(trie.root, wildcards, input, output) } #my trie, starting point, number of wildcards, user input, empty output
print output