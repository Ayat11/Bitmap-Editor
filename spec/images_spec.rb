require 'spec_helper'

describe Image do
  context 'Valid parameters' do
    let(:image) { Image.new(3, 3) }

    it 'should have 2D bitmap array' do
      expect(image.bitmap.is_a?(Array)).to be_truthy
      expect(image.bitmap.first.is_a?(Array)).to be_truthy
    end

    it "should respond to color_pixels" do
      expect(image).to respond_to(:color_pixels)
      image.color_pixels(1, 2, 'S')
      expect(image.bitmap).to eq([['O', 'O', 'O'], ['O', 'O', 'S'], ['O', 'O', 'O']])
    end

    it "should respond to draw_vertical_segment" do
      expect(image).to respond_to(:draw_vertical_segment)
      image.draw_vertical_segment(0, 2, 2, 'V')
      expect(image.bitmap).to eq([['O', 'O', 'V'], ['O', 'O', 'V'], ['O', 'O', 'V']])
    end

    it "should respond to draw_horizontal_segment" do
      expect(image).to respond_to(:draw_horizontal_segment)
      image.draw_horizontal_segment(0, 2, 0, 'H')
      expect(image.bitmap).to eq([['H', 'H', 'H'], ['O', 'O', 'O'], ['O', 'O', 'O']])
    end

    it "should respond to clear" do
      expect(image).to respond_to(:clear)
      image.draw_horizontal_segment(0, 2, 0, 'H')
      expect(image.bitmap).to eq([['H', 'H', 'H'], ['O', 'O', 'O'], ['O', 'O', 'O']])
      image.clear
      expect(image.bitmap).to eq([['O', 'O', 'O'], ['O', 'O', 'O'], ['O', 'O', 'O']])
    end

    it "should respond to fill" do
      expect(image).to respond_to(:fill)
      image.fill(2, 2, 'H')
      expect(image.bitmap).to eq([['H', 'H', 'H'], ['H', 'H', 'H'], ['H', 'H', 'H']])
      image.draw_vertical_segment(0, 2, 2, 'V')
      expect(image.bitmap).to eq([['H', 'H', 'V'], ['H', 'H', 'V'], ['H', 'H', 'V']])
      image.fill(2, 2, 'B')
      expect(image.bitmap).to eq([['H', 'H', 'B'], ['H', 'H', 'B'], ['H', 'H', 'B']])
    end

    it "should respond to bitmap_string" do
      expect(image).to respond_to(:bitmap_string)
    end
  end

  context 'Invalid parameters' do
    it 'should be invalid with no args' do
      expect { Image.new }.to raise_error ArgumentError
    end
  end
end
