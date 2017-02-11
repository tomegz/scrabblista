require 'trie'
trie = Trie.new
IO.readlines('slowa.txt').each { |word| trie.add(word.chomp) }
5.times { puts "DONE" }
trie.save("word_trie")
puts "yay"







