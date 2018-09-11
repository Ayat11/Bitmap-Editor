require 'spec_helper'

describe Commander do
  describe 'create_image' do
    context 'Valid arguments' do
      let(:create_command) { 'I 4 5' }

      it 'should return image object' do
        image = Commander.create_image(create_command, create_command.split(' '))
        expect(image).to be_a Image
        expect(image.bitmap).to be_a Array
        expect(image.rows).to eq(5)
        expect(image.cols).to eq(4)
      end
    end

    context 'invalid arguments' do
      let(:wrong_command_1) { 'I 4 5 H' }
      let(:wrong_command_2) { 'I 4 -5' }

      it 'should not execute with wrong number of arguments' do
        expect { Commander.create_image(wrong_command_1, wrong_command_1.split(' ')) }.to output("'I 4 5 H' failed: Invalid command, wrong number of arguments, expected: 2".colorize(:red) + "\n").to_stdout
      end

      it 'should not create image with false arguments' do
        expect { Commander.create_image(wrong_command_2, wrong_command_2.split(' ')) }.to output("'I 4 -5' failed: Invalid arguments, please make sure you insert a number between 1 and 250.".colorize(:red) + "\n").to_stdout
      end
    end
  end

  describe 'clear_image' do
    let(:clear_command) { 'C' }

    context 'Valid arguments with existing image' do
      let(:image)        { Image.new(2,2) }

      it 'should clear image object' do
        image.color_pixels(1, 1, 'S')
        expect(image.bitmap).to eq([['O','O'], ['O','S']])
        Commander.clear_image(image, clear_command, clear_command.split(' '))
        expect(image.bitmap).to eq([['O','O'], ['O','O']])
      end
    end

    context 'invalid arguments' do
      let(:wrong_command_1) { 'C 1' }

      it 'should not execute with wrong number of arguments' do
        expect { Commander.clear_image(nil, wrong_command_1, wrong_command_1.split(' ')) }.to output("'C 1' failed: Invalid command, wrong number of arguments, expected: 0".colorize(:red) + "\n").to_stdout
      end

      it 'should not execute if there is no existing image' do
        expect { Commander.clear_image(nil, clear_command, clear_command.split(' ')) }.to output("'C' failed: There is no image yet, please make sure you insert an image first.".colorize(:red) + "\n").to_stdout
      end
    end
  end

  describe 'clear_image' do
    let(:show_command) { 'S' }

    context 'Valid arguments with existing image' do
      let(:image)        { Image.new(2,2) }

      it 'should clear image object' do
        expect { Commander.show_image(image, show_command, show_command.split(' ')) }.to output("OO\nOO" + "\n").to_stdout
      end
    end

    context 'invalid arguments' do
      let(:wrong_command_1) { 'S 1' }

      it 'should not execute with wrong number of arguments' do
        expect { Commander.show_image(nil, wrong_command_1, wrong_command_1.split(' ')) }.to output("'S 1' failed: Invalid command, wrong number of arguments, expected: 0".colorize(:red) + "\n").to_stdout
      end

      it 'should not execute if there is no existing image' do
        expect { Commander.show_image(nil, show_command, show_command.split(' ')) }.to output("'S' failed: There is no image yet, please make sure you insert an image first.".colorize(:red) + "\n").to_stdout
      end
    end
  end

  describe 'color_image_pixels' do
    let(:color_command) { 'L 1 1 W' }

    context 'Valid arguments with existing image' do
      let(:image)        { Image.new(2,2) }

      it 'should color image pixel' do
        expect(image.bitmap).to eq([['O','O'], ['O','O']])
        Commander.color_image_pixels(image, color_command, color_command.split(' '))
        expect(image.bitmap).to eq([['W','O'], ['O','O']])
      end
    end

    context 'invalid arguments' do
      let(:wrong_command_1) { 'L 2' }

      it 'should not execute with wrong number of arguments' do
        expect { Commander.color_image_pixels(nil, wrong_command_1, wrong_command_1.split(' ')) }.to output("'L 2' failed: Invalid command, wrong number of arguments, expected: 3".colorize(:red) + "\n").to_stdout
      end

      it 'should not execute if there is no existing image' do
        expect { Commander.color_image_pixels(nil, color_command, color_command.split(' ')) }.to output("'L 1 1 W' failed: There is no image yet, please make sure you insert an image first.".colorize(:red) + "\n").to_stdout
      end
    end
  end

  describe 'vertical_segment' do
    let(:vertical_segment_command) { 'V 2 1 2 F' }
    let(:image) { Image.new(2,2) }

    context 'Valid arguments with existing image' do
      it 'should draw vertical segment' do
        expect(image.bitmap).to eq([['O','O'], ['O','O']])
        Commander.vertical_segment(image, vertical_segment_command, vertical_segment_command.split(' '))
        expect(image.bitmap).to eq([['O','F'], ['O','F']])
      end
    end

    context 'invalid arguments' do
      let(:wrong_command_1) { 'V 3 4' }
      let(:wrong_command_2) { 'V 3 4 5 F' }

      it 'should not execute with wrong number of arguments' do
        expect { Commander.vertical_segment(nil, wrong_command_1, wrong_command_1.split(' ')) }.to output("'V 3 4' failed: Invalid command, wrong number of arguments, expected: 4".colorize(:red) + "\n").to_stdout
      end

      it 'should not execute if there is no existing image' do
        expect { Commander.vertical_segment(nil, vertical_segment_command, vertical_segment_command.split(' ')) }.to output("'V 2 1 2 F' failed: There is no image yet, please make sure you insert an image first.".colorize(:red) + "\n").to_stdout
      end

      it 'should not execute if arguments out of bound' do
        expect { Commander.vertical_segment(image, wrong_command_2, wrong_command_2.split(' ')) }.to output("'V 3 4 5 F' failed: Invalid arguments, out of bounds for the existing image.".colorize(:red) + "\n").to_stdout
      end
    end
  end

  describe 'horizontal_segment' do
    let(:horizontal_segment_command) { 'H 1 2 1 B' }
    let(:image) { Image.new(2,2) }

    context 'Valid arguments with existing image' do
      it 'should draw vertical segment' do
        expect(image.bitmap).to eq([['O','O'], ['O','O']])
        Commander.horizontal_segment(image, horizontal_segment_command, horizontal_segment_command.split(' '))
        expect(image.bitmap).to eq([['B','B'], ['O','O']])
      end
    end

    context 'invalid arguments' do
      let(:wrong_command_1) { 'H 3 4 5 Y Y' }
      let(:wrong_command_2) { 'H 3 4 5 B' }

      it 'should not execute with wrong number of arguments' do
        expect { Commander.horizontal_segment(nil, wrong_command_1, wrong_command_1.split(' ')) }.to output("'H 3 4 5 Y Y' failed: Invalid command, wrong number of arguments, expected: 4".colorize(:red) + "\n").to_stdout
      end

      it 'should not execute if there is no existing image' do
        expect { Commander.horizontal_segment(nil, horizontal_segment_command, horizontal_segment_command.split(' ')) }.to output("'H 1 2 1 B' failed: There is no image yet, please make sure you insert an image first.".colorize(:red) + "\n").to_stdout
      end

      it 'should not execute if arguments out of bound' do
        expect { Commander.horizontal_segment(image, wrong_command_2, wrong_command_2.split(' ')) }.to output("'H 3 4 5 B' failed: Invalid arguments, out of bounds for the existing image.".colorize(:red) + "\n").to_stdout
      end
    end
  end

  describe 'fill_image' do
    let(:fill_image_command) { 'F 1 1 B' }
    let(:vertical_segment_command) { 'V 2 1 2 X' }
    let(:image) { Image.new(2,3) }

    context 'Valid arguments with existing image' do
      it 'should fill the image' do
        expect(image.bitmap).to eq([['O','O','O'], ['O','O','O']])
        Commander.fill_image(image, fill_image_command, fill_image_command.split(' '))
        expect(image.bitmap).to eq([['B','B','B'], ['B','B','B']])
      end

      it 'should fill the region within image' do
        Commander.vertical_segment(image, vertical_segment_command, vertical_segment_command.split(' '))
        expect(image.bitmap).to eq([['O','X','O'], ['O','X','O']])
        Commander.fill_image(image, fill_image_command, fill_image_command.split(' '))
        expect(image.bitmap).to eq([['B','X','O'], ['B','X','O']])
      end
    end

    context 'invalid arguments' do
      let(:wrong_command_1) { 'F 1 2 C V' }
      let(:wrong_command_2) { 'F 2 5 C' }

      it 'should not execute with wrong number of arguments' do
        expect { Commander.fill_image(nil, wrong_command_1, wrong_command_1.split(' ')) }.to output("'F 1 2 C V' failed: Invalid command, wrong number of arguments, expected: 3".colorize(:red) + "\n").to_stdout
      end

      it 'should not execute if there is no existing image' do
        expect { Commander.fill_image(nil, fill_image_command, fill_image_command.split(' ')) }.to output("'F 1 1 B' failed: There is no image yet, please make sure you insert an image first.".colorize(:red) + "\n").to_stdout
      end

      it 'should not execute if arguments out of bound' do
        expect { Commander.fill_image(image, wrong_command_2, wrong_command_2.split(' ')) }.to output("'F 2 5 C' failed: Invalid arguments, out of bounds for the existing image.".colorize(:red) + "\n").to_stdout
      end
    end
  end
end