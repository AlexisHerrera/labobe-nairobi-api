class Version
  MAYOR = 0
  MINOR = 6
  PATCH = 1
  def self.current
    "#{MAYOR}.#{MINOR}.#{PATCH}"
  end
end
