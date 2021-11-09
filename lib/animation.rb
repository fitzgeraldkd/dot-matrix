class Animation
  def initialize(columns, rows, bg_color, fg_color, fps=15, dot_size_formula)
    @columns = columns
    @rows = rows
    @bg_color = bg_color
    @fg_color = fg_color
    @fps = fps
    @keyframes = []
    @dot_size = dot_size_formula
  end

  def add_keyframe(image)
    @keyframes << Frame.new(ImageList.new(image).resize(@columns, @rows))
  end

  def average_colors(color_start, color_end, weight=0.5)
    {
      red: color_start.red * (1 - weight) + color_end.red * weight,
      green: color_start.green * (1 - weight) + color_end.green * weight,
      blue: color_start.blue * (1 - weight) + color_end.blue * weight
    }
  end

  def add_gif_frame(frame, delay)
    @gif << frame.render(@pixel_size, @bg_color, @fg_color, @dot_size)
    @gif.cur_image.delay = delay
  end

  def interpolate_frames(frame_start, frame_end, transition_time)
    frame_duration = 100.0 / @fps
    current_time = frame_duration
    while current_time < transition_time * 100
      frame = Image.new(@columns, @rows)
      (0..@columns-1).each do |x|
        (0..@rows-1).each do |y|
          pixel_start = frame_start.get_pixel(x, y)
          pixel_end = frame_end.get_pixel(x, y)
          weight = current_time / (transition_time * 100)
          new_color = average_colors(pixel_start, pixel_end, weight)
          pixel = Pixel.new(new_color[:red], new_color[:green], new_color[:blue])
          frame.pixel_color(x, y, pixel)
        end
      end
      add_gif_frame(Frame.new(frame), frame_duration)
      current_time += frame_duration
    end
  end

  def render_gif(pixel_size, hold_time, transition_time)
    hold_time = hold_time == 0 ? 1.0/@fps : hold_time
    @gif = ImageList.new
    @gif.ticks_per_second = 100
    @pixel_size = pixel_size
    @keyframes.each_with_index do |keyframe, index|
      next_index = index == @keyframes.length - 1 ? 0 : index + 1
      add_gif_frame(keyframe, hold_time * 100)
      interpolate_frames(keyframe, @keyframes[next_index], transition_time) unless @keyframes.length <= 1
    end
    filename = DateTime.now.strftime("%Y%m%d%H%M%S")
    @gif.write("./output/#{filename}.gif")
    "./output/#{filename}.gif"
  end
end