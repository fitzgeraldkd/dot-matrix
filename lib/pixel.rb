class Pixel
  attr_reader(:x, :y)

  def initialize(orig_color, x, y)
    @orig_color = orig_color
    @x = x
    @y = y
  end

  def s_rgb(value)
    value = value.to_f / 65535
    value <= 0.03928 ? value / 12.92 : ((value + 0.055) / 1.055) ** 2.4
  end

  def relative_luminance
    r = s_rgb(@orig_color.red)
    g = s_rgb(@orig_color.green)
    b = s_rgb(@orig_color.blue)
    (0.2126 * r + 0.7152 * g + 0.0722 * b).round(2)
  end
end