/**
 * Determine the current VGA coordinates of the Bird.
 *
 * We assume the output is a 640x480 VGA display. The bird occupies the
 * leftmost quarter of the screen (0 <= x <= 160).
 *
 * The bird is 40 pixels wide and 40 pixels tall. The bird always straddles
 * x = 80 (so that x_min = 60 and x_max = 100). The bird's x position is given
 * by the bird_height.
 *
 * Note, y increases in the downwards direction.
 */
module VideoBird(bird_height, x_min, x_max, y_min, y_max);
  input [8:0] bird_height;
  output [9:0] x_min, x_max;
  output [8:0] y_min, y_max;

  assign x_min = Constants::BIRD_VGA_X_MIN;
  assign x_max = Constants::BIRD_VGA_X_MAX;
  assign y_min = Constants::VGA_HEIGHT - (bird_height + (Constants::BIRD_VGA_HEIGHT / 9'd2));
  assign y_max = Constants::VGA_HEIGHT - (bird_height - (Constants::BIRD_VGA_HEIGHT / 9'd2));
endmodule: VideoBird

/**
 * Testbench for the VideoBird module.
 */
module VideoBird_testbench();
  logic [8:0] bird_height;
  logic [9:0] x_min, x_max;
  logic [8:0] y_min, y_max;

  VideoBird dut(.bird_height, .x_min, .x_max, .y_min, .y_max);

  initial begin
    bird_height = 9'd20;  #10;
    bird_height = 9'd40;  #10;
    bird_height = 9'd60;  #10;
    bird_height = 9'd20;  #10;
    bird_height = 9'd320; #10;
    bird_height = 9'd460; #10;
  end
endmodule: VideoBird_testbench
