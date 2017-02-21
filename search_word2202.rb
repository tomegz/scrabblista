require 'trie'
require 'benchmark'
# load full word trie
$trie = Trie.read("full_word_trie")
puts "TRIE LOADED"
#methods
def substract(arr1, arr2)
  if arr2.select{ |c| arr1.include? c }.size < arr2.size #handle wildcards
    arr1 = arr1.sort.join.gsub("?","").chars
  end
  arr1 if arr2.empty?
  str = arr1.sort.join
  arr2.each { |l| str.sub!(l,"") }
  str.chars
end
# variables
#$letters = ["a","a","g","u","w"]
#$letters = %w[a b c d e f g h i j k l m n o]
$letters = %w[a b ?]
all_letters = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "r", "s", "t", "u", "w", "y", "z", "ó", "ą", "ć", "ę", "ł", "ń", "ś", "ź", "ż"]
$max_length = $letters.size
$words = []
keys = $letters.uniq
def search_word(keys)
  children = []
  return if keys.empty?
  if keys[0].length == $max_length
    keys.each do |key|
      $words.push(key) if $trie.has_key? key
    end
  else
    keys.each do |key|
      rack = substract($letters, key.chars)
      rack.each do |tile|
        my_key = key + tile
        $words.push(my_key) if $trie.has_key? my_key
        children.push(my_key) if $trie.has_children? my_key
      end
    end
  end
  search_word(children)
end
puts Benchmark.measure{ search_word(keys) }
$words.uniq!
puts "Found words: #{$words.size}"


