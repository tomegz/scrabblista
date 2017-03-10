require 'ext/string'
module Alphabet

	ALPHABET = [
		"a", "b", "c", "d", "e", "f", 
		"g", "h", "i", "j", "k", "l", 
		"m", "n", "o", "p", "r", "s", 
		"t", "u", "w", "y", "z", ")", 
		",", ".", ":", ";", "<", ">", 
		"[", "]"].sort
		#.each{ |c| c.to_ascii_8bit }
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

		# ó - "\xC3\xB3" )
		# ą - "\xC4\x85" ,
		# ć - "\xC4\x87" .
		# ę - "\xC4\x99" :
		# ł - "\xC5\x82" ;
		# ń - "\xC5\x84" <
		# ś - "\xC5\x9B" >
		# ź - "\xC5\xBA" [
		# ż - "\xC5\xBC" ]

end 
