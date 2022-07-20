#!/usr/bin/env ruby

require 'ascii_to_svg'

# Width of one character in pixels
CHAR_WIDTH = 31

# IMAGE DEFINITION
# Content of image (16 characters per line)
image_content = '\ / x - | o + # ' +
                '                ' +
                '+--+ |    +--+ |' +
                '|  | |    |  | |' +
                '|  | |    +--+ |' +
                '|  | |    |  | |' +
                '+--+ +--- |  | o'
# Number of characters per line
line_length = 16
# Image file name
image_name = 'template'

# AVAILABLE IMAGE OPTIONS
options = {
  # CANVAS OPTIONS
  # Size X, Integer, Set width of canvas
  # canvas__size__x: 500,
  canvas__size__x: line_length * CHAR_WIDTH,
  # Margin Left, Integer, Set margin on the left side
  canvas__margin__left: 0,
  # Margin Top, Integer, Set margin on the top side
  canvas__margin__top: 0,
  # Margin Right, Integer, Set margin on the right side
  canvas__margin__right: 0,
  # Margin Bottom, Integer, Set margin on the bottom side
  canvas__margin__bottom: 0,
  # Fill color, String, Define canvas infill color in RGB, you can also use HTML Color names or 'none'
  style__canvas__fill__color: 'rgb(255, 255, 255)',
  # Fill Opacity, Float, Set canvas infill opacity, use floating numbers
  style__canvas__fill__opacity: 1.0,

  # CELL OPTIONS
  # X Offset, Integer, Define the X (width) offset to the next cell
  cell__x__offset: 0,
  # Y Offset, Integer, Define the Y (height) offset to the next cell
  cell__y__offset: 0,

  # LINE
  # Stroke Width, Float, Define width of stroke, please notice linecap type for desired behavior
  style__line__stroke__width: 2.0,
  # Stroke Color, String, Define color of stroke in RGB, you can also use HTML Color names or 'none'
  style__line__stroke__color: 'rgb(0, 0, 0)',
  # Stroke Opacity, Float, Define opacity of the stroke, use floating numbers
  style__line__stroke__opacity: 1.0,
  # Stroke Linecap, String, Defines behavior of line ('butt' / 'round' / 'sqaure')
  style__line__stroke__linecap: 'square',

  # ELLIPSE
  # Stroke Width, Float, Define stroke width, use floating numbers
  style__ellipse__stroke__width: 2.0,
  # Stroke Color, String, Define stroke color in RGB, you can also use HTML Color names or 'none'
  style__ellipse__stroke__color: 'rgb(0, 0, 0)',
  # Stroke Opacity, Float, Set stroke opacity, use floating numbers
  style__ellipse__stroke__opacity: 1.0,
  # Stroke Linecap, String, Defines behavior of ellipse ('butt' / 'round' / 'square')
  style__ellipse__stroke__linecap: 'square',
  # Fill, String, Define color of ellipse fill
  style__ellipse__fill: 'none',

  # RECTANGLE
  # Fill Color, String, Define infill color in RGB, you can also use HTML Color names or 'none'
  style__rectangle__fill__color: 'rgb(0, 0, 0)',
  # Fill Opacity, Float, Set infill opacity, use floating numbers
  style__rectangle__fill__opacity: 1.0,
}

# Generate SVG
svg = AsciiToSvg.from_string(image_content, line_length, options)
# Write generated SVG to a file
File.open(image_name + '.svg', 'w') { | f | f.write(svg) }
