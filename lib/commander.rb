module Commander
  require 'colorize'
  require 'yaml'

  lang = 'en'
  Strings = YAML.load_file("locales/#{lang}.yml")
  
  MIN_RANGE = 1
  MAX_RANGE = 250

  class << self
    def create_image(command_line, command_args)
      execute_command(command_line) do
        rows = command_args[2].to_i
        cols = command_args[1].to_i

        argument_error(command_line, 2) if command_args.length != 3
        
        raise ArgumentError.new("'#{command_line}' failed: Invalid arguments, please make sure you insert a number between 1 and 250.") unless in_range?(rows, cols)

        return Image.new(rows, cols)
      end
    end

    def clear_image(image, command_line, command_args)
      execute_command(command_line) do
        argument_error(command_line, 0) if command_args.length > 1

        image.clear
        return image
      end
    end
  
    def color_image_pixels(image, command_line, command_args)
      execute_command(command_line) do
        col   = command_args[1].to_i
        row   = command_args[2].to_i
        color = command_args[3]

        argument_error(command_line, 3) if command_args.length != 4

        if in_range?(row, col) && within_bitmap?(image.bitmap, row, col)
          image.color_pixels(row-1, col-1, color)
          return image
        else
          raise ArgumentError.new("'#{command_line}' '#{Strings["errors"]["out_of_bounds"]}'")
        end
      end
    end

    def vertical_segment(image, command_line, command_args)
      execute_command(command_line) do
        col   = command_args[1].to_i
        row_1 = command_args[2].to_i
        row_2 = command_args[3].to_i
        color = command_args[4]

        argument_error(command_line, 4) if command_args.length != 5

        if in_range?(row_1, row_2, col) && within_bitmap?(image.bitmap, row_1, col) && within_bitmap?(image.bitmap, row_2, col)
          image.draw_vertical_segment(row_1-1, row_2-1, col-1, color)
          return image
        else
          raise ArgumentError.new("'#{command_line}' #{Strings["errors"]["out_of_bounds"]}")
        end
      end
    end

    def horizontal_segment(image, command_line, command_args)
      execute_command(command_line) do
        col_1 = command_args[1].to_i
        col_2 = command_args[2].to_i
        row   = command_args[3].to_i
        color = command_args[4]

        argument_error(command_line, 4) if command_args.length != 5

        if in_range?(col_1, col_2, row) && within_bitmap?(image.bitmap, row, col_1) && within_bitmap?(image.bitmap, row, col_2)
          image.draw_horizontal_segment(col_1-1, col_2-1, row-1, color)
          return image
        else
          raise ArgumentError.new("'#{command_line}' #{Strings["errors"]["out_of_bounds"]}")
        end
      end
    end

    def show_image(image, command_line, command_args)
      execute_command(command_line) do
        argument_error(command_line, 0) if command_args.length != 1
        image.bitmap_string
      end
    end

    def show_error(error_message)
      puts "#{error_message}".colorize(:red)
    end

    private

    def in_range?(*args)
      args.all? { |e| e.between?(MIN_RANGE, MAX_RANGE) }
    end

    def within_bitmap?(bitmap, row, col)
      bitmap[row-1] && bitmap[row-1][col-1]
    end

    def execute_command(command_line, &block)
      yield
    rescue ArgumentError => e
      show_error(e.message)
    rescue NoMethodError
      no_image_error(command_line)
    end

    def argument_error(command_line, expected_args)
      raise ArgumentError.new("'#{command_line}' #{Strings["errors"]["wrong_num_args"]} #{expected_args}")
    end

    def no_image_error(command_line)
      show_error("'#{command_line}' #{Strings["errors"]["no_image_exists"]}")
    end
  end
end