/**
 * Handles display of game components on the screen.
 *
 * Inputs:
 *   x: The x position of the pixel being rendered.
 *   y: The y position of the pixel being rendered.
 *   bird_x_min: The minimum x position where the bird should be drawn.
 *   bird_x_max: The maximum x position where the bird should be drawn.
 *   bird_y_min: The minimum y position where the bird should be drawn.
 *   bird_y_max: The maximum y position where the bird should be drawn.
 *   obs0_x_min: The minimum x position to draw obs0 top.
 *   obs0_x_max: The maximum x position to draw obs0 top.
 *   obs0_bottom_y_min: The minimum y position to draw obs0 bottom.
 *   obs0_bottom_y_max: The maximum y position to draw obs0 bottom.
 *   obs1_x_min: The minimum x position to draw obs1 top.
 *   obs1_x_max: The maximum x position to draw obs1 top.
 *   obs1_bottom_y_min: The minimum y position to draw obs1 bottom.
 *   obs1_bottom_y_max: The maximum y position to draw obs1 bottom.
 *   obs2_x_min: The minimum x position to draw obs2 top.
 *   obs2_x_max: The maximum x position to draw obs2 top.
 *   obs2_bottom_y_min: The minimum y position to draw obs2 bottom.
 *   obs2_bottom_y_max: The maximum y position to draw obs2 bottom.
 *   game_over: Whether the game is over.
 *
 * Outputs:
 *   r: The red value to display on the pixel.
 *   g: The green value to display on the pixel.
 *   b: The blue value to display on the pixel.
 */
module VideoGame(
    x, y,
    bird_x_min, bird_x_max, bird_y_min, bird_y_max,
    obs0_x_min, obs0_x_max,
    obs0_bottom_y_min, obs0_bottom_y_max, obs0_top_y_min, obs0_top_y_max,
    obs1_x_min, obs1_x_max,
    obs1_bottom_y_min, obs1_bottom_y_max, obs1_top_y_min, obs1_top_y_max,
    obs2_x_min, obs2_x_max,
    obs2_bottom_y_min, obs2_bottom_y_max, obs2_top_y_min, obs2_top_y_max,
    game_over,
    r, g, b);
  input logic [9:0] x;
  input logic [8:0] y;
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
  input logic game_over;
  output logic [7:0] r, g, b;

  always_comb begin
    if (game_over) begin
      r = Constants::GAME_OVER_VGA_R;
      g = Constants::GAME_OVER_VGA_G;
      b = Constants::GAME_OVER_VGA_B;
    end
    else if (bird_x_min <= x && x <= bird_x_max
        && bird_y_min <= y && y <= bird_y_max) begin
      // Draw the bird.
      r = Constants::BIRD_VGA_R;
      g = Constants::BIRD_VGA_G;
      b = Constants::BIRD_VGA_B;
    end
    else if ((obs0_x_min <= x && x <= obs0_x_max
              && (obs0_bottom_y_min <= y && y <= obs0_bottom_y_max
                  || obs0_top_y_min <= y && y <= obs0_top_y_max))
             || (obs1_x_min <= x && x <= obs1_x_max
              && (obs1_bottom_y_min <= y && y <= obs1_bottom_y_max
                  || obs1_top_y_min <= y && y <= obs1_top_y_max))
             || (obs2_x_min <= x && x <= obs2_x_max
              && (obs2_bottom_y_min <= y && y <= obs2_bottom_y_max
                  || obs2_top_y_min <= y && y <= obs2_top_y_max))) begin
      // Draw an obstacle.
      r = Constants::OBSTACLE_VGA_R;
      g = Constants::OBSTACLE_VGA_G;
      b = Constants::OBSTACLE_VGA_B;
    end
    else begin
      r = Constants::BACKGROUND_VGA_R;
      g = Constants::BACKGROUND_VGA_G;
      b = Constants::BACKGROUND_VGA_B;
    end
  end
endmodule: VideoGame

/**
 * Test bench for the VideoGame module.
 */
module VideoGame_testbench();
  logic [9:0] x;
  logic [8:0] y;
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
  logic game_over;
  logic [7:0] r, g, b;

  VideoGame vg(
      .x, .y,
      .bird_x_min, .bird_x_max, .bird_y_min, .bird_y_max,
      .obs0_x_min, .obs0_x_max,
      .obs0_bottom_y_min, .obs0_bottom_y_max, .obs0_top_y_min, .obs0_top_y_max,
      .obs1_x_min, .obs1_x_max,
      .obs1_bottom_y_min, .obs1_bottom_y_max, .obs1_top_y_min, .obs1_top_y_max,
      .obs2_x_min, .obs2_x_max,
      .obs2_bottom_y_min, .obs2_bottom_y_max, .obs2_top_y_min, .obs2_top_y_max,
      .game_over,
      .r, .g, .b);

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
    bird_x_min = 10'd0; bird_x_max = 10'd1; bird_y_min = 9'd1; bird_y_max = 9'd1;

    obs0_x_min = 10'd8; obs0_x_max = 10'd9;
    obs0_bottom_y_min = 9'd5; obs0_bottom_y_max = 9'd7;
    obs0_top_y_min = 9'd0; obs0_top_y_max = 9'd2;

    obs1_x_min = 10'd13; obs1_x_max = 10'd14;
    obs1_bottom_y_min = 9'd5; obs1_bottom_y_max = 9'd7;
    obs1_top_y_min = 9'd0; obs1_top_y_max = 9'd3;

    obs2_x_min = 10'd18; obs2_x_max = 10'd19;
    obs2_bottom_y_min = 9'd4; obs2_bottom_y_max = 9'd7;
    obs2_top_y_min = 9'd0; obs2_top_y_max = 9'd1;
    game_over = 1'b0;

    // Background.
    x = 10'd0; y = 9'd0; #10;

    // Bird
    x = 10'd1; y = 9'd1; #10;

    // Obstacle 0 top.
    x = 10'd9; y = 9'd2; #10;

    // Obstacle 1 bottom.
    x = 10'd13; y = 9'd6; #10;

    // Obstacle 2 top.
    x = 10'd19; y = 9'd0; #10;

    // Obstacle 0 gap.
    x = 10'd1; y = 9'd3; #10;

    // Collision.
    game_over = 1'b1; #10;
    x = 10'd0; y = 9'd0; #10;
  end
endmodule: VideoGame_testbench
