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

  def render(pixel_size, bg_color, fg_color, dot_size)
    image = Image.new(@image.columns * pixel_size, @image.rows * pixel_size) {|options|
      options.background_color = bg_color
    }
    gc = Draw.new
    gc.fill(fg_color)
    process_image
    @pixels.each do |pixel|
      origin_x = (pixel.x + 0.5) * pixel_size
      origin_y = (pixel.y + 0.5) * pixel_size
      radius = (pixel_size / 2) * dot_size.call(pixel.relative_luminance)
      gc.circle(origin_x, origin_y, origin_x + radius, origin_y)
    end
    gc.draw(image)
    image
  end
end