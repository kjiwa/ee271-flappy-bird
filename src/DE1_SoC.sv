/**
 * Flying Dot: A Flappy Bird clone for the DE1.
 *
 * This game requires a VGA monitor.
 *
 *   SW[9] resets the game.
 *   SW[8] resets the clock divider and VGA display.
 *   KEY[0] causes the bird to fly (or move up).
 *
 * Inputs:
 *   CLOCK_50: A 50 Hz clock.
 *   KEY: An array of user-pressable buttons.
 *   SW: An array of user-controllable switches.
 *
 * Outputs:
 *   HEX0: A seven-segment display.
 *   HEX1: A seven-segment display.
 *   HEX2: A seven-segment display.
 *   HEX3: A seven-segment display.
 *   VGA_R:
 *   VGA_G:
 *   VGA_B:
 *   VGA_BLANK_N:
 *   VGA_CLK:
 *   VGA_HS:
 *   VGA_SYNC_N:
 *   VGA_VS:
 */
import Constants::*;

module DE1_SoC(
    CLOCK_50, KEY, SW, HEX0, HEX1, HEX2, HEX3, VGA_R, VGA_G, VGA_B,
    VGA_BLANK_N, VGA_CLK, VGA_HS, VGA_SYNC_N, VGA_VS);
  input logic CLOCK_50;
  input logic [3:0] KEY;
  input logic [9:0] SW;
  output logic [6:0] HEX0, HEX1, HEX2, HEX3;
  output VGA_BLANK_N, VGA_CLK, VGA_HS, VGA_SYNC_N, VGA_VS;
  output [7:0] VGA_R, VGA_G, VGA_B;

  // Initialize clock.
  logic [31:0] clocks;
  ClockDivider cd(.clock(CLOCK_50), .reset(SW[8]), .dividedClocks(clocks));

  // Connect reset signal.
  logic reset;
  assign reset = SW[9];

  // Connect KEY[0] through two DFFs.
  logic key0Dff0, key0Dff1;
  DFlipFlop dff0(
      .clock(clocks[Constants::BIRD_CLOCK_SCALE]), .reset, .data(KEY[0]),
      .q(key0Dff0));
  DFlipFlop dff1(
      .clock(clocks[Constants::BIRD_CLOCK_SCALE]), .reset, .data(key0Dff0),
      .q(key0Dff1));

  // Initialize video driver.
  logic [9:0] x;
  logic [8:0] y;
  logic [7:0] r, g, b;

  VideoDriver vd(
      .CLOCK_50, .reset(SW[8]), .x, .y, .r, .g, .b, .VGA_R, .VGA_G, .VGA_B,
      .VGA_BLANK_N, .VGA_CLK, .VGA_HS, .VGA_SYNC_N, .VGA_VS);

  // Create game objects.
  logic [8:0] bird_height;
  Bird bird(
      .clock(clocks[Constants::BIRD_CLOCK_SCALE]), .reset, .fly(~key0Dff1),
      .height(bird_height));

  logic [9:0] obs0_distance, obs1_distance, obs2_distance;
  logic [8:0] obs0_height, obs1_height, obs2_height;
  logic [8:0] obs0_gap_height, obs1_gap_height, obs2_gap_height;
  Obstacle obs0(
      .clock(clocks[Constants::OBSTACLE_CLOCK_SCALE]), .reset,
      .initial_distance(Constants::OBSTACLE0_INITIAL_DISTANCE),
      .initial_height(Constants::OBSTACLE0_INITIAL_HEIGHT),
      .initial_gap_height(Constants::OBSTACLE0_INITIAL_GAP_HEIGHT),
      .distance(obs0_distance),
      .height(obs0_height),
      .gap_height(obs0_gap_height));
  Obstacle obs1(
      .clock(clocks[Constants::OBSTACLE_CLOCK_SCALE]), .reset,
      .initial_distance(Constants::OBSTACLE1_INITIAL_DISTANCE),
      .initial_height(Constants::OBSTACLE1_INITIAL_HEIGHT),
      .initial_gap_height(Constants::OBSTACLE1_INITIAL_GAP_HEIGHT),
      .distance(obs1_distance),
      .height(obs1_height),
      .gap_height(obs1_gap_height));
  Obstacle obs2(
      .clock(clocks[Constants::OBSTACLE_CLOCK_SCALE]), .reset,
      .initial_distance(Constants::OBSTACLE2_INITIAL_DISTANCE),
      .initial_height(Constants::OBSTACLE2_INITIAL_HEIGHT),
      .initial_gap_height(Constants::OBSTACLE2_INITIAL_GAP_HEIGHT),
      .distance(obs2_distance),
      .height(obs2_height),
      .gap_height(obs2_gap_height));

  // Create game video output.
  logic [9:0] bird_x_min, bird_x_max;
  logic [8:0] bird_y_min, bird_y_max;
  VideoBird vb(
      .bird_height, .x_min(bird_x_min), .x_max(bird_x_max), .y_min(bird_y_min),
      .y_max(bird_y_max));

  logic [9:0] obs0_x_min, obs0_x_max;
  logic [8:0] obs0_bottom_y_min, obs0_bottom_y_max;
  logic [8:0] obs0_top_y_min, obs0_top_y_max;
  logic [9:0] obs1_x_min, obs1_x_max;
  logic [8:0] obs1_bottom_y_min, obs1_bottom_y_max;
  logic [8:0] obs1_top_y_min, obs1_top_y_max;
  logic [9:0] obs2_x_min, obs2_x_max;
  logic [8:0] obs2_bottom_y_min, obs2_bottom_y_max;
  logic [8:0] obs2_top_y_min, obs2_top_y_max;
  VideoObstacle vo0(
      .distance(obs0_distance),
      .height(obs0_height),
      .gap_height(obs0_gap_height),
      .x_min(obs0_x_min), .x_max(obs0_x_max),
      .bottom_y_min(obs0_bottom_y_min), .bottom_y_max(obs0_bottom_y_max),
      .top_y_min(obs0_top_y_min), .top_y_max(obs0_top_y_max));
  VideoObstacle vo1(
      .distance(obs1_distance),
      .height(obs1_height),
      .gap_height(obs1_gap_height),
      .x_min(obs1_x_min), .x_max(obs1_x_max),
      .bottom_y_min(obs1_bottom_y_min), .bottom_y_max(obs1_bottom_y_max),
      .top_y_min(obs1_top_y_min), .top_y_max(obs1_top_y_max));
  VideoObstacle vo2(
      .distance(obs2_distance),
      .height(obs2_height),
      .gap_height(obs2_gap_height),
      .x_min(obs2_x_min), .x_max(obs2_x_max),
      .bottom_y_min(obs2_bottom_y_min), .bottom_y_max(obs2_bottom_y_max),
      .top_y_min(obs2_top_y_min), .top_y_max(obs2_top_y_max));

  // Collision detector.
  logic collision;
  CollisionDetector cdet(
      .bird_x_min, .bird_x_max, .bird_y_min, .bird_y_max,
      .obs0_x_min, .obs0_x_max,
      .obs0_bottom_y_min, .obs0_bottom_y_max, .obs0_top_y_min, .obs0_top_y_max,
      .obs1_x_min, .obs1_x_max,
      .obs1_bottom_y_min, .obs1_bottom_y_max, .obs1_top_y_min, .obs1_top_y_max,
      .obs2_x_min, .obs2_x_max,
      .obs2_bottom_y_min, .obs2_bottom_y_max, .obs2_top_y_min, .obs2_top_y_max,
      .collision);

  // Game state tracker.
  logic game_over;
  GameStateTracker gst(.clock(CLOCK_50), .reset, .collision, .game_over);

  // Score counter.
  logic [9:0] score;
  ScoreCounter sc(
      .clock(clocks[Constants::OBSTACLE_CLOCK_SCALE]), .reset,
      .obs0_x_max, .obs1_x_max, .obs2_x_max,
      .game_over, .score);

  // The game driver.
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

  // Display the score.
  logic [9:0] score0;
  logic [9:0] score1;
  logic [9:0] score2;
  logic [9:0] score3;
  assign score0 = score % 10'd10;
  assign score1 = (score / 10'd10) % 10'd10;
  assign score2 = (score / 10'd100) % 10'd10;
  assign score3 = (score / 10'd1000) % 10'd10;

  OneDigitDisplay odd0(.value(score0[3:0]), .hex(HEX0));
  OneDigitDisplay odd1(.value(score1[3:0]), .hex(HEX1));
  OneDigitDisplay odd2(.value(score2[3:0]), .hex(HEX2));
  OneDigitDisplay odd3(.value(score3[3:0]), .hex(HEX3));
endmodule: DE1_SoC

/**
 * Test bench for the DE1_SoC module.
 */
module DE1_SoC_testbench();
  logic CLOCK_50, VGA_BLANK_N, VGA_CLK, VGA_HS, VGA_SYNC_N, VGA_VS;
  logic [3:0] KEY;
  logic [9:0] SW;
  logic [6:0] HEX0, HEX1, HEX2, HEX3;
  logic [7:0] VGA_R, VGA_G, VGA_B;

  DE1_SoC dut(
      .CLOCK_50, .KEY, .SW, .HEX0, .HEX1, .HEX2, .HEX3, .VGA_R, .VGA_G, .VGA_B,
      .VGA_BLANK_N, .VGA_CLK, .VGA_HS, .VGA_SYNC_N, .VGA_VS);

  parameter CLOCK_PERIOD = 2;
  initial begin
    CLOCK_50 <= 0;
    forever #(CLOCK_PERIOD / 2) CLOCK_50 <= ~CLOCK_50;
  end

  parameter n = 2**20;
  integer i, j;
  initial begin
                 for (i = 0; i < n; ++i) @(posedge CLOCK_50);
    KEY <= 4'b1111; SW <= 10'b0000000000;
                 for (i = 0; i < n; ++i) @(posedge CLOCK_50);
    SW[8] <= 1;  for (i = 0; i < n; ++i) @(posedge CLOCK_50);
    SW[8] <= 0;  for (i = 0; i < n; ++i) @(posedge CLOCK_50);
    SW[9] <= 1;  for (i = 0; i < n; ++i) @(posedge CLOCK_50);
    SW[9] <= 0;  for (i = 0; i < n; ++i) @(posedge CLOCK_50);
                 for (i = 0; i < n; ++i) @(posedge CLOCK_50);

    // Let the bird fall to the floor and eventually hit an obstacle.
    for (i = 0; i < n; ++i) begin
        @(posedge CLOCK_50);
    end

    // Flap around randomly.
    SW[9] <= 1;  for (i = 0; i < n; ++i) @(posedge CLOCK_50);
    SW[9] <= 0;  for (i = 0; i < n; ++i) @(posedge CLOCK_50);
    for (i = 0; i < 30; ++i) begin
      KEY[0] <= $urandom(); for (j = 0; j < n; ++j) @(posedge CLOCK_50);
    end

    $stop;
  end
endmodule: DE1_SoC_testbench
