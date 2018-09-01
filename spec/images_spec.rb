require 'spec_helper'

describe Image do
  context 'Valid parameters' do
    let(:image) { Image.new(5, 5) }

    it 'should have 2D bitmap array' do
      expect(image.bitmap.is_a?(Array)).to be_truthy
      expect(image.bitmap.first.is_a?(Array)).to be_truthy
    end

    it "should respond to show" do
      expect(image).to respond_to(:show)
    end
  end

  context 'Invalid parameters' do
    it 'should be invalid' do
      expect { Image.new }.to raise_error ArgumentError
    end
  end
end
