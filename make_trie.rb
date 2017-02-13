require 'trie'
trie = Trie.new
IO.readlines('slowa.txt').each do |word| 
  w = word.chomp
  trie.add(w.length.to_s + w.chars.sort.join + w) 
end
trie.save("word_trie")







