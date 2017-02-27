class String
  def to_ascii_8bit
    self.force_encoding("ascii-8bit")
  end
end