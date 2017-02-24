$letters = %w[a b ?]
all_letters = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "r", "s", "t", "u", "w", "y", "z", "ó", "ą", "ć", "ę", "ł", "ń", "ś", "ź", "ż"]

if $letters.include? "?"
  without_blanks = $letters.join.gsub("?","")
  keys = all_letters.map { |l| (l+without_blanks).chars.sort }
else
  keys = $letters.uniq
end
print keys
