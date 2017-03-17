require 'trie'
trie = Trie.new
change = {
  "ó" => ")",
  "ą" => ",",
  "ć" => ".",
  "ę" => ":",
  "ł" => ";",
  "ń" => "<",
  "ś" => ">",
  "ź" => "[",
  "ż" => "]"
}
points = {
  "a" => 1, 
  "b" => 3, 
  "c" => 2, 
  "d" => 2, 
  "e" => 1, 
  "f" => 5, 
  "g" => 3, 
  "h" => 3, 
  "i" => 1, 
  "j" => 3, 
  "k" => 2, 
  "l" => 2, 
  "m" => 2, 
  "n" => 1, 
  "o" => 1, 
  "p" => 2, 
  "q" => 1,
  "r" => 1, 
  "s" => 1, 
  "t" => 2, 
  "u" => 3, 
  "v" => 1,
  "w" => 1, 
  "x" => 1,
  "y" => 2, 
  "z" => 1, 
  ")" => 5, 
  "," => 5, 
  "." => 6, 
  ":" => 5, 
  ";" => 3, 
  "<" => 7, 
  ">" => 5, 
  "[" => 9, 
  "]" => 5
}
def calculate_points(word, points)
  result = 0
  word.chars.each do |c| 
    #puts "#{c} in #{word}"
    result += points[c] 
  end
  result
end
IO.readlines('slowa.txt').each do |word| 
  w = word.chomp
  change.each do |key, value|
    w.gsub!(key, value)
  end
  trie.add(w, calculate_points(w, points))
end
trie.save("p_10_03_2017_trie")
    # ó - "\xC3\xB3" )
    # ą - "\xC4\x85" ,
    # ć - "\xC4\x87" .
    # ę - "\xC4\x99" :
    # ł - "\xC5\x82" ;
    # ń - "\xC5\x84" <
    # ś - "\xC5\x9B" >
    # ź - "\xC5\xBA" [
    # ż - "\xC5\xBC" ]







