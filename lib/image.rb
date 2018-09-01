class Image
  WHITE = 'O'

  attr_reader :bitmap

  def initialize(row, col)
    @bitmap = Array.new(row) { Array.new(col, WHITE) }
  end

  def color_pixels(row, col, color)
    @bitmap[row][col] = color
  end

  def draw_vertical_segment(row_1, row_2, col, color)
    (row_1..row_2).each do |row|
      @bitmap[row][col] = color
    end
  end

  def bitmap_string
    @bitmap.map{ |row| puts row.join }
  end
end
