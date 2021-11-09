class DotMatrixCLI < Thor
  option :subfolder,
         :type => :string,
         :desc => "Name of the subfolder in ./assets where the images are kept. Can be left blank to process all images in the ./assets folder."
  option :columns,
         :type => :numeric,
         :desc => "Number of columns in the resulting dot matrix",
         :default => DEFAULTS[:columns]
  option :rows,
         :type => :numeric,
         :desc => "Number of rows in the resulting dot matrix",
         :default => DEFAULTS[:rows]
  option :bg_color,
         :type => :string,
         :desc => "Background color",
         :default => DEFAULTS[:bg_color]
  option :fg_color,
         :type => :string,
         :desc => "Foreground color",
         :default => DEFAULTS[:fg_color]
  option :fps,
         :type => :numeric,
         :desc => "Framerate (an approximate frames per second)",
         :default => DEFAULTS[:fps]
  option :dot_size,
         :type => :numeric,
         :desc => "Max diameter of each dot in the matrix, in pixels",
         :default => DEFAULTS[:dot_size]
  option :transition_time,
         :type => :numeric,
         :desc => "Amount of time it takes to transition between keyframes, in seconds",
         :default => DEFAULTS[:transition_time]
  option :hold_time,
         :type => :numeric,
         :desc => "Amount of time the animation will pause on a keyframe, in seconds. If set to 0 there will be no additional delay on keyframes compared to transitional frames.",
         :default => DEFAULTS[:hold_time]
  
  desc "render_gif", "Render a GIF"
  long_desc <<-LONGDESC
    'render_gif' will take all of the images in a selected folder and create a dot matrix animation using them.
    The images will be sorted and processed by filename, so if a specific order is needed you can set the filenames to determine the order.

    See above for the list of available options.
  LONGDESC
  def render_gif
    if options[:subfolder]
      folder = "./assets/#{options[:subfolder]}"
    else
      folder = './assets'
    end

    begin
      files = Dir.entries(folder).filter do |file|
        file.end_with?('.bmp', '.gif', '.jpeg', '.jpg', '.png', '.tif', '.tiff')
      end.sort

      Pixel.from_color(options[:bg_color])
      Pixel.from_color(options[:fg_color])
    rescue Errno::ENOENT
      puts "The folder (#{folder}) does not exist."
    rescue ArgumentError
      puts "Input color not recognized. View RMagick documentation for allowable color name inputs: https://rmagick.github.io/imusage.html#color_names"
    else
      puts "#{files.length} images found in #{folder}"
      animation = Animation.new(
        options[:columns],
        options[:rows],
        options[:bg_color],
        options[:fg_color],
        options[:fps],
        DOT_SIZE_FORMULA
      )
      puts "The animation will proceed in this order:"
      files.each do |filename|
        puts "  #{filename}"
        animation.add_keyframe("#{folder}/#{filename}")
      end

      puts "Rendering the GIF, this may take some time..."
      animation_path = animation.render_gif(
        options[:dot_size],
        options[:hold_time],
        options[:transition_time]
      )
      puts "Animation saved to #{animation_path}"
    end
  end
end