class Tile
  # validations here!
  include Alphabet
  attr_reader :inputted, :wildcards, :tiles

  def initialize(letters)
    @inputted = letters.downcase
    P_LETTERS.each { |key, value| @inputted.gsub!(key, value) }
    @inputted = @inputted.chars.sort
    @wildcards = @inputted.select{ |c| c=="?" }.size
    @tiles =  @wildcards > 0 ? @inputted.join.gsub("?","").chars : @inputted
  end
  
end