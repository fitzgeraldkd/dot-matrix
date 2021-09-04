require 'rmagick'
include Magick

def get_index(x, y, columns, rows)
    columns -= 1
    rows -= 1
    x_index = x.to_s.rjust(columns.to_s.size, "0")
    y_index = y.to_s.rjust(rows.to_s.size, "0")
    return x_index + y_index
end

def s_rgb (value)
    value = value.to_f / 65535
    return value <= 0.03928 ? value / 12.92 : ((value + 0.055) / 1.055) ** 2.4
end

def relative_luminance(pixel)
    r = s_rgb(pixel.red)
    g = s_rgb(pixel.green)
    b = s_rgb(pixel.blue)
    return (0.2126 * r + 0.7152 * g + 0.0722 * b).round(2)
end

def process_image (filename, columns, rows)
    source = ImageList.new(filename).resize(columns, rows)
    state = {}
    (0..columns-1).each do |x|
        (0..rows-1).each do |y|
            index = get_index(x, y, columns, rows)
            lum = relative_luminance(source.pixel_color(x, y))
            state[index] = 1 - lum
        end
    end
    return state
end

# def delay_style (columns, rows)
#     delay = 0
#     delay_increment = 0.1
#     style = []
#     (0..columns+rows-1).each do |i|
#         style.append
#     end
# end

def blank_state (columns, rows)
    state = {}
    (0..columns-1).each do |x|
        (0..rows-1).each do |y|
            index = get_index(x, y, columns, rows)
            state[index] = 0
        end
    end
    return state
end

def join_states(states)
    joined = []
    this_state = 0
    states.each do |state|
        unique = {}
        state.each do |key, value|
            if unique.key?(value)
                unique[value] << key
            else
                unique[value] = [key]
            end
        end
        if joined.length == 0
            unique.each do |key, value|
                joined.append({
                    "ids": value,
                    "states": Hash[this_state, key]
                })
            end
        else
            unique.each do |key, value|
                joined.each do |group|
                    if (group.ids - value).empty?
                        # append to joined
                    else
                        # split items in joined
                    end
                end
            end
        end
        this_state += 1
    end
    p joined
end

def create_css(states, columns, rows)
    size = 16
    contents = []
    contents.append(".dotmatrix-dot {")
    contents.append("    animation-duration: 5s;")
    contents.append("    animation-iteration-count: infinite;")
    contents.append("}")
    contents.append("")

    keys = states[0].keys
    keys.each do |key|
        contents.append("#dotmatrix-index-#{key} {")
        contents.append("    animation-name: kf#{key};")
        contents.append("    transform-origin: #{(2 * (key[0..1]).to_i + 1) * size}px #{(2 * (key[2..3]).to_i + 1) * size}px;")
        contents.append("}")
        contents.append("")
        contents.append("@keyframes kf#{key} {")
        for i in 0...states.size do
            percent = (i * 100 / (states.size - 1)).round()
            contents.append("    #{percent}% { transform: scale(#{(states[i][key])**2}); }")
        end
        contents.append("}")
        contents.append("")
    end

    (0..columns+rows-1).each do |i|
        contents.append(".dotmatrix-delay-#{i} { animation-delay: calc(var(--delay-increment) * #{i}); }")
    end
    p contents
    File.open("dotmatrix-animation.css", "w") do |f|
        f.puts(contents)
    end
end

if __FILE__ == $0
    # process_image("logotest.png", 16, 16)
    p blank_state(16, 16)
    create_css([blank_state(16, 16), process_image("k-logo.png", 16, 16), process_image("d-logo.png", 16, 16), process_image("f-logo.png", 16, 16), blank_state(16, 16)], 16, 16)
    # join_states([process_image("logotest.png", 16, 16), process_image("logotest2.png", 16, 16), blank_state(16, 16)])
end