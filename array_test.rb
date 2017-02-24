def substract(arr1, arr2)
  diff = arr1.size - arr2.size
  if arr2.select{ |c| arr1.include? c }.size < arr2.size
    arr1 = arr1.sort.join.gsub("?","").chars
  end
  arr1 if arr2.empty?
  str = arr1.sort.join
  arr2.each { |l| str.sub!(l,"") }
  if str.chars.size - arr2.size >= diff
    str.sub!("?","")
  end
  str.chars
end

print substract(%w[a b ?], %w[a])
puts "k"
print substract(%w[a a g u w], %w[w])
puts "k"
print substract(%w[a a g u w], %w[a a g u w])
puts "k"
print substract(%w[a a g u w], %w[a a g w u])
puts "k"
print substract(%w[a a g u w], %w[])
puts "k"
