class Image
  WHITE = 'O'

  attr_reader :bitmap

  def initialize(rows, cols)
    @rows = rows
    @cols = cols
    @bitmap = Array.new(@rows) { Array.new(@cols, WHITE) }
  end

  def color_pixels(row, col, color)
    @bitmap[row][col] = color
  end

  def draw_vertical_segment(row_1, row_2, col, color)
    (row_1..row_2).each do |row|
      @bitmap[row][col] = color
    end
  end

  def draw_horizontal_segment(col_1, col_2, row, color)
    (col_1..col_2).each do |col|
      @bitmap[row][col] = color
    end
  end

  def bitmap_string
    @bitmap.map{ |row| puts row.join }
  end

  def clear
    @bitmap = Array.new(@rows) { Array.new(@cols, WHITE) }
  end
end
