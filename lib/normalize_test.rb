P_LETTERS = {
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
P_LETTERS_MIRROR = P_LETTERS.invert
def normalize(word)
  normalized = word
  P_LETTERS_MIRROR.each do |key, value| 
    normalized = normalized.gsub(key, value)
  end
  normalized
end
words_to_normalize = ["keks", "k)pa", "b)l"]
output = []
words_to_normalize.each{ |w| output.push(normalize(w)) }
puts output
puts words_to_normalize