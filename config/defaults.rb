DEFAULTS = {
  columns: 16,
  rows: 16,
  bg_color: 'white',
  fg_color: 'black',
  fps: 15,
  dot_size: 16, # in pixels
  transition_time: 1, # in seconds
  hold_time: 1, # in seconds
}

DOT_SIZE_FORMULA = -> (lum) { (1 - lum) ** 2 }