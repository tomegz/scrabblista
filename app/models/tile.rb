class Tile
  # validations here!
  attr_reader :tiles, :wildcards
  def initialize(letters)
    @tiles = letters.chars.sort
    @wildcards = @tiles.select{ |c| c=="?" }.size
    @tiles = @tiles.join.gsub("?","").chars if @wildcards > 0
  end
  
end