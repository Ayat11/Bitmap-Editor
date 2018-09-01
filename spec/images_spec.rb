require 'spec_helper'

describe Image do
  context 'Valid parameters' do
    let(:image) { Image.new(5, 5) }

    it 'should have 2D bitmap array' do
      expect(image.bitmap.is_a?(Array)).to be_truthy
      expect(image.bitmap.first.is_a?(Array)).to be_truthy
    end

    it "should respond to color_pixels" do
      expect(image).to respond_to(:color_pixels)
    end

    it "should respond to draw_vertical_segment" do
      expect(image).to respond_to(:draw_vertical_segment)
    end

    it "should respond to draw_horizontal_segment" do
      expect(image).to respond_to(:draw_horizontal_segment)
    end

    it "should respond to clear" do
      expect(image).to respond_to(:clear)
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
