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
IO.readlines('slowa.txt').each do |word| 
  w = word.chomp
  puts "at najlepszy" if w == "najlepszy"
  change.each do |key, value|
    w.gsub!(key, value)
  end
  trie.add(w)
end
trie.save("p_trie")
    # ó - "\xC3\xB3" )
    # ą - "\xC4\x85" ,
    # ć - "\xC4\x87" .
    # ę - "\xC4\x99" :
    # ł - "\xC5\x82" ;
    # ń - "\xC5\x84" <
    # ś - "\xC5\x9B" >
    # ź - "\xC5\xBA" [
    # ż - "\xC5\xBC" ]







