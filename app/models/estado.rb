class Estado
  attr_reader :updated_on, :created_on

  attr_accessor :estado

  def initialize(estado)
    @estado = estado
  end
end
