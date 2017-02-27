class Tile
  # validations here!
  attr_reader :inputted, :wildcards, :tiles

  def initialize(letters)
    @inputted = letters.downcase.chars.sort
    @wildcards = @inputted.select{ |c| c=="?" }.size
    @tiles =  @wildcards > 0 ? @inputted.join.gsub("?","").chars : @inputted
  end
  
end