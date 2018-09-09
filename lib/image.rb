class Image
  WHITE = 'O'

  attr_reader :bitmap, :rows, :cols

  def initialize(rows, cols)
    @rows = rows
    @cols = cols
    @bitmap = Array.new(@rows) { Array.new(@cols, WHITE) }
  end

  def color_pixels(row, col, color)
    @bitmap[row][col] = color[0].upcase
  end

  def draw_vertical_segment(row_1, row_2, col, color)
    rows = [row_1, row_2]
    ((rows.min..rows.max)).each do |row|
      @bitmap[row][col] = color[0].upcase
    end
  end

  def draw_horizontal_segment(col_1, col_2, row, color)
    cols = [col_1, col_2]
    (cols.min..cols.max).each do |col|
      @bitmap[row][col] = color[0].upcase
    end
  end

  def bitmap_string
    @bitmap.map{ |row| puts row.join }
  end

  def clear
    @bitmap = Array.new(@rows) { Array.new(@cols, WHITE) }
  end
end
