class Tile
  # validations here!
  def initialize(letters)
    @tiles = letters.chars.sort
  end
end