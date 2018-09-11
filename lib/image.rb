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

  def fill(row, col, color)
    current_color = @bitmap[row][col]
    color_and_check_adjacent(row, col, current_color, color)
  end

  def bitmap_string
    @bitmap.map{ |row| puts row.join }
  end

  def clear
    @bitmap = Array.new(@rows) { Array.new(@cols, WHITE) }
  end

  private

  def coordinates_valid(coordinates)
    [coordinates[:row], coordinates[:col]].all? { |i| i >= 0 }
  end

  def color_and_check_adjacent(row, col, current_color, new_color)
    color_pixels(row, col, new_color)

    coordinates = { right: {row: row, col: col+1}, 
                    left: {row: row, col: col-1}, 
                    upper: {row: row-1, col: col},
                    lower: {row: row+1, col: col}
                  }

    coordinates.each do |dir, coor|
      cell = @bitmap[coor[:row]][coor[:col]] if coordinates_valid(coor) && @bitmap[coor[:row]]
      color_and_check_adjacent(coor[:row], coor[:col], current_color, new_color) if cell == current_color
    end
  end
end
