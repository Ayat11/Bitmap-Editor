module Commander
  class << self
    def create_image(command_line, command_args)
      rows = command_args[1].to_i
      cols = command_args[2].to_i
      
      return puts "'#{command_line}': Invalid command invalid args" unless rows && cols && in_range?(rows, cols)

      new_image = Image.new(rows, cols)

      if new_image.bitmap
        return new_image
      else
        return puts "'#{command_line}': Invalid command"
      end
    end

    def clear_image(image, command_line, command_args)
      return puts "'#{command_line}': Invalid command missing args" if command_args.length > 1

      if image.is_a?(Image)
        image.clear
        return image
      else
        return puts "There is no image"
      end
    end
  
    def color_image_pixels(image, command_line, command_args)
      col   = command_args[1].to_i
      row   = command_args[2].to_i
      color = command_args[3]

      return puts "'#{command_line}': Invalid command missing args" if command_args.length != 4

      if image.is_a?(Image)
        if in_range?(row, col) && within_bitmap?(image.bitmap, row, col)
          image.color_pixels(row-1, col-1, color)
          return image
        else
          return puts "'#{command_line}': Invalid command invalid args"
        end
      else
        return puts "There is no image"
      end
    end
  
    def vertical_segment(image, command_line, command_args)
      col   = command_args[1].to_i
      row_1 = command_args[2].to_i
      row_2 = command_args[3].to_i
      color = command_args[4]

      return puts "'#{command_line}': Invalid command missing args" if command_args.length != 5

      if image.is_a?(Image)
        if in_range?(row_1, row_2, col) && within_bitmap?(image.bitmap, row_1, col) && within_bitmap?(image.bitmap, row_2, col)
          image.draw_vertical_segment(row_1-1, row_2-1, col-1, color)
          return image
        else
          return puts "'#{command_line}': Invalid command invalid args"
        end
      else
        return puts "There is no image"
      end
    end

    def horizontal_segment(image, command_line, command_args)
      col_1 = command_args[1].to_i
      col_2 = command_args[2].to_i
      row   = command_args[3].to_i
      color = command_args[4]

      return puts "'#{command_line}': Invalid command missing args" if command_args.length != 5

      if image.is_a?(Image)
        if in_range?(col_1, col_2, row) && within_bitmap?(image.bitmap, row, col_1) && within_bitmap?(image.bitmap, row, col_2)
          image.draw_horizontal_segment(col_1-1, col_2-1, row-1, color)
          return image
        else
          return puts "'#{command_line}': Invalid command invalid args"
        end
      else
        return puts "There is no image"
      end
    end
  
    def show_image(image)
      if image.is_a?(Image)
        image.bitmap_string
      else
        return puts "There is no image"
      end
    end

    private

    def in_range?(*args)
      args.all? { |e| e.between?(1, 250) }
    end

    def within_bitmap?(bitmap, row, col)
      bitmap[row-1] && bitmap[row-1][col-1]
    end
  end
end