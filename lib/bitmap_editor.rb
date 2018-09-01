class BitmapEditor
  require_relative 'image'
  require_relative 'commander'

  include Commander

  def run(file)
    output_line("please provide correct file") if file.nil? || !File.exists?(file)

    current_image = nil

    File.open(file).each do |line|
      line = line.chomp
      next if line == ""
      command_args = line.split(' ')
      command = command_args.first

      case command
      when 'S'
        Commander.show_image(current_image)
      when 'I'
        current_image = Commander.create_image(line, command_args)
        break unless current_image
      when 'L'
        current_image = Commander.color_image_pixels(current_image, line, command_args)
        break unless current_image
      when 'V'
        current_image = Commander.vertical_segment(current_image, line, command_args)
        break unless current_image
      when 'H'
        current_image = Commander.horizontal_segment(current_image, line, command_args)
        break unless current_image
      when 'C'
        current_image = Commander.clear_image(current_image, line, command_args)
        break unless current_image
      else
        puts 'unrecognised command :('
      end
    end
  end
end
