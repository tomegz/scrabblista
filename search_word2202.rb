require 'trie'
require 'benchmark'
# load full word trie
$trie = Trie.read("full_word_trie")
puts "TRIE LOADED"
#methods
def substract(arr1, arr2)
  #if arr2.select{ |c| arr1.include? c }.size <= arr2.size #handles 1 wildcard so far!
    #arr1 = arr1.sort.join.gsub("?","").chars
  #end
  arr1 if arr2.empty?
  str = arr1.sort.join
  arr2.each { |l| str.sub!(l,"") }
  if str.chars.include? "?" 
    #..
  else
  end
    str.chars
end
def to_key(key_with_blank)
  key_with_blank.gsub("'","")
end
def to_blank(letter, alphabet)
  alphabet.find_index(letter) #changes "a'" to 1 etc..
end
def to_letter(blank, alphabet)
  if blank.is_a? Integer
    alphabet[blank] # changes "1" to "a"
  else
    blank
  end
end
def key_to_word(key)
  key.gsub(/\S'/,"?") # S - non whitespace
end
# variables
#$letters = ["a","a","g","u","w"]
#$letters = %w[a b c d e f g h i j k l m n o]
$letters = %w[a b c d e f g h i j k l m n o]
all_letters = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "r", "s", "t", "u", "w", "y", "z", "ó", "ą", "ć", "ę", "ł", "ń", "ś", "ź", "ż"]
$max_length = $letters.size
$words = []

if $letters.include? "?"
  keys = $letters.map do |l| 
    if l == "?"
      l = all_letters.map{ |l| l+"'" } 
    else
      l 
    end
  end.flatten.uniq
else
  keys = $letters.uniq # why uniq?
end
def search_word(keys)
  #puts "Received params: #{keys}"
  children = []
  return if keys.empty?
  if keys[0].length == $max_length
    keys.each do |key|
      $words.push(to_key(key)) if $trie.has_key? to_key(key)
    end
  else
    keys.each do |key|
      rack = substract($letters, key_to_word(key).chars) # passes a?b instead of aa'b
      #puts "For key: #{key} the rack is #{rack}"
      rack.each do |tile|
        my_key = key + tile
        $words.push(to_key(my_key)) if $trie.has_key? to_key(my_key)
        children.push(my_key) if $trie.has_children? to_key(my_key)
      end
    end
  end
  search_word(children)
end
puts Benchmark.measure{ search_word(keys) }
$words.uniq!
puts "Found words: #{$words.size}"






