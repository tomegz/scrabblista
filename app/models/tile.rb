class Tile
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  # validations here!
  attr_accessor :inputted, :wildcards, :tiles

  #validates :inputted, exclusion: { in: %w(# ?) }

  validates :wildcards, inclusion: { in: 2..9 }

  def initialize(letters)
    @inputted = letters.chars.sort
    @wildcards = @inputted.select{ |c| c=="?" }.size
    @tiles =  @wildcards > 0 ? @inputted.join.gsub("?","").chars : @inputted
  end
  
end