class Keyframe
  def initialize(image)
    @image = image
    @pixels = []
  end

  def pixels
    @pixels
  end

  def process_image(columns, rows)
    (0..columns-1).each do |x|
      (0..rows-1).each do |y|
        @pixels.push(Pixel.new(@image.pixel_color(x, y), x, y))
      end
    end
  end
end