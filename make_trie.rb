require 'trie'
tries = []
14.times{ tries.push(Trie.new) }
IO.readlines('slowa.txt').each do |word| 
  w = word.chomp
  puts "at najlepszy" if w == "najlepszy"
  l = w.length - 2
  tries[l].add(w)
  #trie.add(w.length.to_s + w.chars.sort.join + w)
  #if trie.get(key).nil?
    #word_or_array = []
  #else
    #word_or_array = trie.get(key).push(w)
  #end
  #trie.add(key, word_or_array)
  #w.length.times{ |n| trie.add(w.length.to_s + w.sub(/#{word[n-1]}/,"?").chars.sort.join + word) }
end
tries.each_with_index{ |t, i| t.save("#{i}_letter_trie") }







