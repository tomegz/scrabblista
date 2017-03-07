class Tile
  # validations here!
  include Alphabet
  attr_reader :input, :wildcards, :tiles

  def initialize(letters)
    @input = letters.downcase.gsub(/\s+/,"")
    @input_change = letters.downcase.gsub(/\s+/,"")
    P_LETTERS.each { |key, value| @input_change.gsub!(key, value) }
    @input_change = @input_change.chars.sort
    @wildcards = @input_change.select{ |c| c=="?" }.size
    @tiles = @wildcards > 0 ? @input_change.join.gsub("?","").chars : @input_change
  end
  
end