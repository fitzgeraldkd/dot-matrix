class Animation
  def initialize(columns, rows, bg_color, fps=15)
    @columns = columns
    @rows = rows
    @bg_color = bg_color
    @fps = fps
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

  def average_colors(color_start, color_end, weight=0.5)
    {
      red: color_start.red * (1 - weight) + color_end.red * weight,
      green: color_start.green * (1 - weight) + color_end.green * weight,
      blue: color_start.blue * (1 - weight) + color_end.blue * weight
    }
  end

  def interpolate_frames(frame_start, frame_end, transition_time)
    frame_count = 0
    frame_duration = 100.0 / @fps # TODO: duplicated calc here
    frames = []
    while frame_count < transition_time * 100
      frame = Image.new(@columns, @rows)
      (0..@columns-1).each do |x|
        (0..@rows-1).each do |y|
          pixel_start = frame_start.get_pixel(x, y)
          pixel_end = frame_end.get_pixel(x, y)
          new_color = average_colors(pixel_start, pixel_end, frame_count / (transition_time * 100))
          pixel = Pixel.new(new_color[:red], new_color[:green], new_color[:blue])
          frame.pixel_color(x, y, pixel)
        end
      end
      frames << frame
      frame_count += frame_duration
    end
    frames
  end

  def render_gif(pixel_size, hold_time, transition_time)
    gif = ImageList.new
    gif.ticks_per_second = 60
    @keyframes.each_with_index do |keyframe, index|
      next_index = index == @keyframes.length - 1 ? 0 : index + 1
      gif.push(render_frame(pixel_size, keyframe))
      gif.cur_image.delay = 100 * hold_time

      transition_frames = interpolate_frames(keyframe, @keyframes[next_index], transition_time)
      transition_frames.each do |image|
        frame = Keyframe.new(image)
        frame.process_image(@columns, @rows)
        gif << render_frame(pixel_size, frame)
        gif.cur_image.delay = 100.0 / @fps # TODO: duplicated calc here
      end
    end
    filename = DateTime.now.strftime("%Y%m%d%H%M%S")
    gif.write("./output/#{filename}.gif")
  end
end