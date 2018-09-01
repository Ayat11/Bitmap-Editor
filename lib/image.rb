class Image
  WHITE = 'O'

  attr_reader :bitmap

  def initialize(row, col)
    @bitmap = Array.new(row) { Array.new(col, WHITE) }
  end

  def color_pixels(row, col, color)
    @bitmap[row][col] = color
  end

  def bitmap_string
    @bitmap.map{ |row| puts row.join }
  end
end
