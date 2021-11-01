class Animation
  def initialize(columns, rows, bg_color)
    @columns = columns
    @rows = rows
    @bg_color = bg_color
    @keyframes = []
  end

  def add_keyframe(image)
    @keyframes.push(Keyframe.new(ImageList.new(image).resize(@columns, @rows)))
  end

  def process_keyframes
    @keyframes.each {|keyframe| keyframe.process_image(@columns, @rows)}
  end

  def render_frame(pixel_size, frame)
    image = Image.new(@columns * pixel_size, @rows * pixel_size)
    gc = Magick::Draw.new
    frame.pixels.each do |pixel|
      origin_x = (pixel.x + 0.5) * pixel_size
      origin_y = (pixel.y + 0.5) * pixel_size
      gc.circle(origin_x, origin_y, origin_x + pixel_size / 2 * (1 - pixel.relative_luminance), origin_y)
    end
    gc.draw(image)
    image
  end

  def render_gif(pixel_size, hold_time, transition_time)
    gif = ImageList.new
    gif.ticks_per_second = 60
    @keyframes.each do |keyframe|
      # frame = Image.new(@columns * pixel_size, @rows * pixel_size)
      # gc = Magick::Draw.new
      # # gc.fill_opacity(1)
      # # gc.fill('black')
      # keyframe.pixels.each do |pixel|
      #   origin_x = (pixel.x + 0.5) * pixel_size
      #   origin_y = (pixel.y + 0.5) * pixel_size
      #   gc.circle(origin_x, origin_y, origin_x + pixel_size / 2 * (1 - pixel.relative_luminance), origin_y)
      # end
      # gc.draw(frame)
      # gif.push(frame)
      gif.push(render_frame(pixel_size, keyframe))
      # TODO: update to have variable delay
      gif.cur_image.delay = 60
    end
    gif.write('testing2.gif')
  end
end