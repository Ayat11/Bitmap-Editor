class BitmapEditor
  require_relative 'image'
  require_relative 'commander'

  include Commander

  def run(file)
    if file.nil?
      help_text = File.open('bin/help.txt','rb').read
      return puts help_text.colorize(:magenta)
    end 

    return Commander.show_error(Strings["errors"]["no_file"]) if !File.exists?(file)

    current_image = nil

    File.open(file).each do |line|
      line = line.chomp
      next if line == ""
      command_args = line.split(' ')
      command = command_args.first

      case command
      when 'S'
        bitmap = Commander.show_image(current_image, line, command_args)
        puts "\n" if bitmap
        break unless bitmap
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
        Commander.show_error("'#{line}': " + Strings["errors"]["unrecognised_command"])
        break
      end
    end
  end
end
