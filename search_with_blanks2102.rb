require 'trie'
# load full word trie
$trie = Trie.read("full_word_trie")
puts "TRIE LOADED"
#methods
#methods
def substract(arr1, arr2)
  exp_diff = arr1.size - arr2.size
  if arr2.select{ |c| arr1.include? c }.size < arr2.size
    arr1 = arr1.sort.join.gsub("?","").chars
  end
  arr1 if arr2.empty?
  str = arr1.sort.join
  arr2.each { |l| str.sub!(l,"") }
  if str.chars.size != exp_diff
    str.sub!("?", "")
  end
  str.chars
end
# variables
#$letters = ["a","a","g","u","w"]
$letters = %w[a b c d e f g h i j k l m n o p r]
$all_letters = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "r", "s", "t", "u", "w", "y", "z", "ó", "ą", "ć", "ę", "ł", "ń", "ś", "ź", "ż"]
$max_length = $letters.size
$words = []
keys = []
keys = $letters.uniq
def search_word(keys)
  children = []
  #puts "Received params: #{keys}"
  return if keys.empty?
  #new part
  keys_with_blanks = keys.select{ |k| k.include? "?" }
  keys_with_blanks.uniq!
  #puts keys_with_blanks
  unless keys_with_blanks.empty?
    keys_with_blanks.map! do |k|
      k = $all_letters.map{ |l| l.gsub(l, k+l) }
    end.flatten!.map!{ |k| k.gsub("?", "").chars.join }.uniq!
    #puts "Keys with blanks: #{keys_with_blanks}"
    keys.delete_if{ |k| k.include? "?" }
    keys += keys_with_blanks
  end
 
  ###
  if keys[0].length == $max_length
    keys.each do |key|
      $words.push(key) if $trie.has_key? key
    end
  else
    keys.each do |key|
      $words.push(key) if $trie.has_key? key
      rack = substract($letters, key.chars)
      #puts "For key: #{key} the rack is: #{rack}"
      rack.each do |tile|
        my_key = key + tile
        $words.push(my_key) if $trie.has_key? my_key
        children.push(my_key) if $trie.has_children? my_key
        children.push(my_key) if my_key.include? "?"
      end
    end
  end
  search_word(children)
end
puts "searching..."
search_word(keys)

$words.uniq!
puts "Found words: #{$words.size}"
