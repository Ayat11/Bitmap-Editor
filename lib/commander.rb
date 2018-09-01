module Commander
  class << self
    def create_image(command_line, command_args)
      rows = command_args[1]
      cols = command_args[2]
      
      return puts "'#{command_line}': Invalid command" unless rows && cols

      new_image = Image.new(rows, cols)

      if new_image.bitmap
        return new_image
      else
        return puts "'#{command_line}': Invalid command"
      end
    end

    def clear_image
    end
  
    def color_pixels(image, row, col, color)
    end
  
    def vertical_segment(image, row_1, row_2, col, color)
    end
  
    def horizontal_segment(image, row, col_1, col_2, color)
    end
  
    def show_image(image)
      if image.is_a?(Image)
        image.bitmap_string
      else
        return puts "There is no image"
      end
    end
  end
end