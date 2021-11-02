class Keyframe
  attr_reader :pixels

  def initialize(image)
    @image = image
    @pixels = []
  end

  def process_image(columns, rows)
    (0..columns-1).each do |x|
      (0..rows-1).each do |y|
        @pixels.push(Dot.new(get_pixel(x, y), x, y))
      end
    end
  end

  def get_pixel(x, y)
    @image.pixel_color(x, y)
  end
end