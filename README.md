<p align="center">
  <img src="bitmaplogo.png">
</p>

# Bitmap Editor

## Description 

Bitmap editor simulates a basic interactive bitmap editor. Bitmaps
are represented as an M x N matrix of pixels with each element representing a colour.

## Requirements
```
- Ruby '2.3.4'
```

## Installation
Clone the repo then do the following:
```sh
bundle install
```

## Usage
```sh
bin/bitmap_editor examples/show.txt
```


## Testing
- Used rspec and capybara.
- To run the tests:
```sh
rspec
```

## Extra Gems used

- [Colorize](https://github.com/fazibear/colorize) for colorizing console output.


## Components

### Image Class

Represents image object which has bitmap property to operate on and visualize the bitmap.

#### Properties


| Property | Type | Description |
| --- | --- | --- |
| bitmap | <code>Array</code> | 2D array of pixels |
| rows | <code>Integer</code> | represents rows count |
| cols | <code>Array</code> | represnts column count |

#### Methods


| Method | Arguments | Description |
| --- | --- | --- |
| initialize | <code>(rows, cols)</code> | Initializes image object with bitmap with given dimensions |
| color_pixels | <code>(row, col, color)</code> | colors selected pixel with given color |
| draw_vertical_segment | <code>(row_1, row_2, col, color)</code> | Draws vertical segment between row_1 and row_2 in the selected column using given color |
| draw_horizontal_segment | <code>(col_1, col_2, row, color)</code> | Draws horizontal segment between col_1 and col_2 in the selected row using given color |
| bitmap_string | <code>()</code> | Returns image bitmap in string format for viewing |
| clear | <code>()</code> | Clears the image bitmap pixels to the default value |


### Commander Module

Supporting Module for the Bitmap Editor for executing supported commands. It acts as a wrapper for interacting with the Image class.

#### Supported commands

```ruby
 create_image
 clear_image
 color_image_pixels
 vertical_segment
 horizontal_segment
 show_image
```


### Bitmap Editor (main)

Main class for Bitmap Editor, it loads a file of commands and applies each command sequentially.


#### Supported commands

- `I N M` - Create a new M x N image with all pixels coloured white (O).
- `C` - Clears the table, setting all pixels to white (O).
- `L X Y C` - Colours the pixel (X,Y) with colour C.
- `V X Y1 Y2 C` - Draw a vertical segment of colour C in column X between rows Y1 and Y2 (inclusive).
- `H X1 X2 Y C` - Draw a horizontal segment of colour C in row Y between columns X1 and X2 (inclusive).
- `S` - Show the contents of the current image


## Extra Notes
- If X1/X2 or Y1/Y2 in Vertical/Horizontal commands are swapped, Bitmap Editor will handle it correctly (handle it for the user)

- Bitmap Editor will throw an error if invalid number of command arguments are used.  

- Bitmap Editor will throw an error if given arguments are out of bounds [1,250] or non-integer input.  

- **Lowercase letters** representing the colors are handled by uppercasing them always.

## Issues faced
- Colorize was planned to be used to color the resulting bitmap on the console, however due to the nature of how colorize works, it was breaking the Specs, since it was adding extra characters to the console output.

## Copyright
Ayat Elsayed, 2018