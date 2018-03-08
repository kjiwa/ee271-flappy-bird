/**
 * A collision detector. Checks if the bird has flown into an obstacle.
 *
 * Inputs:
 *   bird_x_min: The minimum x position where the bird should be drawn.
 *   bird_x_max: The maximum x position where the bird should be drawn.
 *   bird_y_min: The minimum y position where the bird should be drawn.
 *   bird_y_max: The maximum y position where the bird should be drawn.
 *   obs0_x_min: The minimum x position where obstacle 0 should be drawn.
 *   obs0_x_max: The maximum x position where obstacle 0 should be drawn.
 *   obs0_bottom_y_min: The minimum y of the bottom of obstacle 0.
 *   obs0_bottom_y_max: The maximum y of the bottom of obstacle 0.
 *   obs0_top_y_min: The minimum y of the bottom of obstacle 0.
 *   obs0_top_y_max: The maximum y of the bottom of obstacle 0.
 *   obs1_x_min: The minimum x position where obstacle 1 should be drawn.
 *   obs1_x_max: The maximum x position where obstacle 1 should be drawn.
 *   obs1_bottom_y_min: The minimum y of the bottom of obstacle 1.
 *   obs1_bottom_y_max: The maximum y of the bottom of obstacle 1.
 *   obs1_top_y_min: The minimum y of the bottom of obstacle 1.
 *   obs1_top_y_max: The maximum y of the bottom of obstacle 1.
 *   obs2_x_min: The minimum x position where obstacle 2 should be drawn.
 *   obs2_x_max: The maximum x position where obstacle 2 should be drawn.
 *   obs2_bottom_y_min: The minimum y of the bottom of obstacle 2.
 *   obs2_bottom_y_max: The maximum y of the bottom of obstacle 2.
 *   obs2_top_y_min: The minimum y of the bottom of obstacle 2.
 *   obs2_top_y_max: The maximum y of the bottom of obstacle 2.
 *
 * Outputs:
 *   collision: Whether the bird has collided with something.
 */
module CollisionDetector(
    bird_x_min, bird_x_max, bird_y_min, bird_y_max,
    obs0_x_min, obs0_x_max,
    obs0_bottom_y_min, obs0_bottom_y_max, obs0_top_y_min, obs0_top_y_max,
    obs1_x_min, obs1_x_max,
    obs1_bottom_y_min, obs1_bottom_y_max, obs1_top_y_min, obs1_top_y_max,
    obs2_x_min, obs2_x_max,
    obs2_bottom_y_min, obs2_bottom_y_max, obs2_top_y_min, obs2_top_y_max,
    collision);
  input logic [9:0] bird_x_min, bird_x_max;
  input logic [8:0] bird_y_min, bird_y_max;
  input logic [9:0] obs0_x_min, obs0_x_max;
  input logic [8:0] obs0_bottom_y_min, obs0_bottom_y_max;
  input logic [8:0] obs0_top_y_min, obs0_top_y_max;
  input logic [9:0] obs1_x_min, obs1_x_max;
  input logic [8:0] obs1_bottom_y_min, obs1_bottom_y_max;
  input logic [8:0] obs1_top_y_min, obs1_top_y_max;
  input logic [9:0] obs2_x_min, obs2_x_max;
  input logic [8:0] obs2_bottom_y_min, obs2_bottom_y_max;
  input logic [8:0] obs2_top_y_min, obs2_top_y_max;
  output logic collision;

  assign collision = (
      (bird_x_max >= obs0_x_min && bird_x_min <= obs0_x_max
       && (bird_y_max >= obs0_bottom_y_min || bird_y_min <= obs0_top_y_max))
      || (bird_x_max >= obs1_x_min && bird_x_min <= obs1_x_max
          && (bird_y_max >= obs1_bottom_y_min || bird_y_min <= obs1_top_y_max))
      || (bird_x_max >= obs2_x_min && bird_x_min <= obs2_x_max
          && (bird_y_max >= obs2_bottom_y_min || bird_y_min <= obs2_top_y_max)));
endmodule: CollisionDetector

/**
 * Test bench for the CollisionDetector module.
 */
module CollisionDetector_testbench();
  logic [9:0] bird_x_min, bird_x_max;
  logic [8:0] bird_y_min, bird_y_max;
  logic [9:0] obs0_x_min, obs0_x_max;
  logic [8:0] obs0_bottom_y_min, obs0_bottom_y_max;
  logic [8:0] obs0_top_y_min, obs0_top_y_max;
  logic [9:0] obs1_x_min, obs1_x_max;
  logic [8:0] obs1_bottom_y_min, obs1_bottom_y_max;
  logic [8:0] obs1_top_y_min, obs1_top_y_max;
  logic [9:0] obs2_x_min, obs2_x_max;
  logic [8:0] obs2_bottom_y_min, obs2_bottom_y_max;
  logic [8:0] obs2_top_y_min, obs2_top_y_max;
  logic collision;

  CollisionDetector dut(
      .bird_x_min, .bird_x_max, .bird_y_min, .bird_y_max,
      .obs0_x_min, .obs0_x_max,
      .obs0_bottom_y_min, .obs0_bottom_y_max, .obs0_top_y_min, .obs0_top_y_max,
      .obs1_x_min, .obs1_x_max,
      .obs1_bottom_y_min, .obs1_bottom_y_max, .obs1_top_y_min, .obs1_top_y_max,
      .obs2_x_min, .obs2_x_max,
      .obs2_bottom_y_min, .obs2_bottom_y_max, .obs2_top_y_min, .obs2_top_y_max,
      .collision);

  initial begin
    // Pretend we have a 20x8 monitor and position the bird and obstacles.
    //
    //    01234567890123456789
    //   +--------------------+
    // 0 |        00   11   22|
    // 1 |        00   11     |
    // 2 |        00   11     |
    // 3 |             11     |
    // 4 |                  22|
    // 5 |        00   11   22|
    // 6 |        00   11   22|
    // 7 |        00   11   22|
    //   +--------------------+
    obs0_x_min = 10'd8; obs0_x_max = 10'd9;
    obs0_bottom_y_min = 9'd5; obs0_bottom_y_max = 9'd7;
    obs0_top_y_min = 9'd0; obs0_top_y_max = 9'd2;

    obs1_x_min = 10'd13; obs1_x_max = 10'd14;
    obs1_bottom_y_min = 9'd5; obs1_bottom_y_max = 9'd7;
    obs1_top_y_min = 9'd0; obs1_top_y_max = 9'd3;

    obs2_x_min = 10'd18; obs2_x_max = 10'd19;
    obs2_bottom_y_min = 9'd4; obs2_bottom_y_max = 9'd7;
    obs2_top_y_min = 9'd0; obs2_top_y_max = 9'd1;

    // No collision when the bird has x in [0, 1] and y in [0, 1].
    bird_x_min = 10'd0; bird_x_max = 10'd1; bird_y_min = 9'd1; bird_y_max = 9'd2; #10;

    // The bird hits obstacle 0 bottom.
    bird_x_min = 10'd7; bird_x_max = 10'd8; bird_y_min = 9'd6; bird_y_max = 9'd7; #10;

    // The bird hits obstacle 1 top.
    bird_x_min = 10'd13; bird_x_max = 10'd14; bird_y_min = 9'd1; bird_y_max = 9'd2; #10;

    // The bird hits obstacle 2 bottom.
    bird_x_min = 10'd18; bird_x_max = 10'd19; bird_y_min = 9'd5; bird_y_max = 9'd6; #10;

    // The bird is in unoccupied space.
    bird_x_min = 10'd0; bird_x_max = 10'd1; bird_y_min = 9'd1; bird_y_max = 9'd2; #10;

    // The bird is in the gap of obstacle 0.
    bird_x_min = 10'd8; bird_y_max = 10'd9; bird_y_min = 9'd4; bird_y_max = 9'd4; #10;

    // The bird hits the ceiling.
    bird_x_min = 10'd0; bird_x_max = 10'd1; bird_y_min = 9'd0; bird_y_max = 9'd1; #10;

    // The bird hits the floor.
    bird_x_min = 10'd0; bird_x_max = 10'd1; bird_y_min = 9'd6; bird_y_max = 9'd7; #10;
  end
endmodule
