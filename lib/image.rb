class Image
  WHITE = 'O'

  attr_reader :bitmap 

  def initialize(row, col)
    @bitmap = Array.new(row) { Array.new(col, WHITE) }
  end

  def show
    @bitmap.map{ |row| puts row.join }
  end
end
