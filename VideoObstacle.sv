/**
 * Map the obstacle's distance into VGA coordinates. Obstacles are 80 units
 * wide.
 *
 * Inputs:
 *   distance: The distance of the obstacle from position 0.
 *   height: The height of the obstacle.
 *   gap_height: The gap between ends of the obstacle.
 *
 * Outputs:
 *   x_min: The smallest x value where the obstacle should be shown.
 *   x_max: The largest VGA x value.
 *   bottom_y_min: The smallest VGA y value for the bottom of the obstacle.
 *   bottom_y_max: The largest VGA y value.
 *   top_y_min: The smallest VGA x value for the top of the obstacle.
 *   top_y_max: The largest VGA y value.
 */
module VideoObstacle(
    distance, height, gap_height,
    x_min, x_max, bottom_y_min, bottom_y_max, top_y_min, top_y_max);
  input logic [9:0] distance;
  input logic [8:0] height, gap_height;
  output logic [9:0] x_min, x_max;
  output logic [8:0] bottom_y_min, bottom_y_max, top_y_min, top_y_max;

  assign x_max = distance;
  assign bottom_y_min = Constants::VGA_HEIGHT - height;
  assign bottom_y_max = Constants::VGA_HEIGHT;
  assign top_y_min = 9'd0;
  assign top_y_max = Constants::VGA_HEIGHT - (height + gap_height);

  always_comb begin
    if (distance <= Constants::OBSTACLE_VGA_WIDTH)
      x_min = 10'd0;
    else begin
      x_min = distance - Constants::OBSTACLE_VGA_WIDTH;
    end
  end
endmodule: VideoObstacle

/**
 * Testbench for the VideoObstacle module.
 */
module VideoObstacle_testbench();
  logic [9:0] distance, x_min, x_max;
  logic [8:0] height, gap_height;
  logic [8:0] bottom_y_min, bottom_y_max, top_y_min, top_y_max;

  VideoObstacle dut(
      .distance, .height, .gap_height,
      .x_min, .x_max, .bottom_y_min, .bottom_y_max, .top_y_min, .top_y_max);

  initial begin
    distance = 10'd20;  height = 9'd50; gap_height = 9'd10; #10;
    distance = 10'd40;  height = 9'd50; gap_height = 9'd10; #10;
    distance = 10'd60;  height = 9'd90; gap_height = 9'd10; #10;
    distance = 10'd20;  height = 9'd50; gap_height = 9'd20; #10;
    distance = 10'd40;  height = 9'd50; gap_height = 9'd20; #10;
    distance = 10'd60;  height = 9'd90; gap_height = 9'd20; #10;
  end
endmodule: VideoObstacle_testbench
