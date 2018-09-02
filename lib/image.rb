class Image
  WHITE = 'O'

  attr_reader :bitmap

  def initialize(rows, cols)
    @rows = rows
    @cols = cols
    @bitmap = Array.new(@rows) { Array.new(@cols, WHITE) }
  end

  def color_pixels(row, col, color)
    @bitmap[row][col] = color.colorize(random_colorize)
  end

  def draw_vertical_segment(row_1, row_2, col, color)
    random_color = random_colorize
    (row_1..row_2).each do |row|
      @bitmap[row][col] = color.colorize(random_color)
    end
  end

  def draw_horizontal_segment(col_1, col_2, row, color)
    random_color = random_colorize
    (col_1..col_2).each do |col|
      @bitmap[row][col] = color.colorize(random_color)
    end
  end

  def bitmap_string
    @bitmap.map{ |row| puts row.join }
  end

  def clear
    @bitmap = Array.new(@rows) { Array.new(@cols, WHITE) }
  end

  private

  def random_colorize
    [:red, :green, :yellow, :blue, :magenta, :cyan][rand(0..5)]
  end
end
