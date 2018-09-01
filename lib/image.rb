class Image
  WHITE = 'O'

  attr_reader :bitmap 

  def initialize(r, c)
    row = r.to_i
    col = c.to_i

    if in_range?(row, col)
      @bitmap = Array.new(row) { Array.new(col, WHITE) }
    else
      @bitmap = nil
    end
  end

  def bitmap_string
    @bitmap.map{ |row| puts row.join }
  end

  protected

  def in_range?(row, col)
    [row, col].all? { |e| e.between?(1, 250) }
  end
end
