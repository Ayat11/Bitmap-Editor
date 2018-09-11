require 'spec_helper'

feature 'Bitmap editor' do
  let(:input_directory) {"spec/files/input"}
  let(:output_directory) {"spec/files/output"}
  let(:test_command) {"bin/bitmap_editor"}

  context 'With valid input files' do
    scenario 'with the given test case' do
      output = File.read("#{output_directory}/valid_1.txt")
      expect { system("#{test_command} #{input_directory}/valid_1.txt") }.to output("#{output}\n").to_stdout_from_any_process
    end
    
    scenario 'with the lower case colors' do
      output = File.read("#{output_directory}/lowercase_colors.txt")
      expect { system("#{test_command} #{input_directory}/lowercase_colors.txt") }.to output("#{output}\n").to_stdout_from_any_process
    end

    scenario 'with another test case' do
      output = File.read("#{output_directory}/valid_2.txt")
      expect { system("#{test_command} #{input_directory}/valid_2.txt") }.to output("#{output}\n").to_stdout_from_any_process
    end

    scenario 'with fill test case' do
      output = File.read("#{output_directory}/valid_fill.txt")
      expect { system("#{test_command} #{input_directory}/valid_fill.txt") }.to output("#{output}\n").to_stdout_from_any_process
    end

    scenario 'with fill hole test case' do
      output = File.read("#{output_directory}/hole_fill.txt")
      expect { system("#{test_command} #{input_directory}/hole_fill.txt") }.to output("#{output}\n").to_stdout_from_any_process
    end
  end

  context 'With invalid input files' do
    scenario 'with non existing file' do
      expect { system("#{test_command} #{input_directory}/file.txt") }.to output("please provide correct file.".colorize(:red) + "\n").to_stdout_from_any_process
    end

    scenario 'with show command first' do
      expect { system("#{test_command} #{input_directory}/invalid_show.txt") }.to output("'S' failed: There is no image yet, please make sure you insert an image first.".colorize(:red) + "\n").to_stdout_from_any_process
    end

    scenario 'with missing args command' do
      expect { system("#{test_command} #{input_directory}/invalid_args_missing.txt") }.to output("'I 4' failed: Invalid command, wrong number of arguments, expected: 2".colorize(:red) + "\n").to_stdout_from_any_process
    end

    scenario 'with invalid command' do
      expect { system("#{test_command} #{input_directory}/invalid_command.txt") }.to output("'B 1 1': unrecognised command :(".colorize(:red) + "\n").to_stdout_from_any_process
    end

    scenario 'with invalid fill test case' do
      expect { system("#{test_command} #{input_directory}/invalid_fill.txt") }.to output("'F 2 R' failed: Invalid command, wrong number of arguments, expected: 3".colorize(:red) + "\n").to_stdout_from_any_process
    end
  end
end
