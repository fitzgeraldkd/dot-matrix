class Frame
  attr_reader :pixels

  def initialize(image)
    @image = image
    @pixels = []
  end

  def process_image
    (0..@image.columns-1).each do |x|
      (0..@image.rows-1).each do |y|
        @pixels << Dot.new(get_pixel(x, y), x, y)
      end
    end
  end

  def get_pixel(x, y)
    @image.pixel_color(x, y)
  end
end