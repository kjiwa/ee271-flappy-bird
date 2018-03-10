/**
 * An obstacle that the bird must fly through. The obstacle moves 1 unit to the
 * left every clock cycle.
 *
 * Inputs:
 *   clock: The reference clock.
 *   reset: The reset signal.
 *   initial_distance: The initial obstacle distance.
 *   initial_height: The initial obstacle height.
 *   initial_gap_height: The initial obstacle gap height.
 *
 * Outputs:
 *   distance: How far away the obstacle is from position 0.
 *   height: The height of the obstacle.
 *   gap_height: The distance between ends of the obstacle.
 */
import Constants::*;
 
module Obstacle(
    clock, reset,
    initial_distance, initial_height, initial_gap_height,
    distance, height, gap_height);
  input logic clock, reset;
  input logic [9:0] initial_distance;
  input logic [8:0] initial_height, initial_gap_height;
  output logic [9:0] distance;
  output logic [8:0] height, gap_height;

  logic [8:0] randomHeight, randomGapHeight;
  NineBitLinearFeedbackShiftRegister lfsr1(.clock, .reset, .q(randomHeight));
  NineBitLinearFeedbackShiftRegister lfsr2(.clock, .reset, .q(randomGapHeight));

  logic [9:0] next_distance;
  logic [8:0] next_height, next_gap_height;
  always_comb begin
    if (distance == 10'd0) begin
      // Cycle back around to the rightmost edge of the screen.
      next_distance = Constants::OBSTACLE_MAX_DISTANCE;

      // Choose a random new height and gap height.
      next_height = randomHeight % Constants::OBSTACLE_MAX_HEIGHT;
      if (next_height < Constants::OBSTACLE_MIN_HEIGHT)
        next_height = OBSTACLE_MIN_HEIGHT;

      next_gap_height = randomGapHeight % Constants::OBSTACLE_MAX_GAP_HEIGHT;
      if (next_gap_height < Constants::OBSTACLE_MIN_GAP_HEIGHT)
        next_gap_height = OBSTACLE_MIN_GAP_HEIGHT;
    end
    else begin
      // Scroll left.
      next_distance = distance - 10'd1;
      next_height = height;
      next_gap_height = gap_height;
    end
  end

  always_ff @(posedge clock) begin
    if (reset) begin
      distance <= initial_distance;
      height <= initial_height;
      gap_height <= initial_gap_height;
    end
    else begin
      distance <= next_distance;
      height <= next_height;
      gap_height <= next_gap_height;
    end
  end
endmodule: Obstacle

/**
 * Testbench for the Obstacle module.
 */
module Obstacle_testbench();
  logic clock, reset;
  logic [9:0] initial_distance, distance;
  logic [8:0] initial_height, initial_gap_height, height, gap_height;

  Obstacle dut(
      .clock, .reset,
      .initial_distance, .initial_height, .initial_gap_height,
      .distance, .height, .gap_height);

  parameter CLOCK_PERIOD = 100;
  initial begin
    clock <= 0;
    forever #(CLOCK_PERIOD / 2) clock <= ~clock;
  end

  integer i;
  initial begin
                @(posedge clock);
    initial_distance <= 10'd720; initial_height <= 9'd120; initial_gap_height <= 9'd160;
    reset <= 1;                                          @(posedge clock);
    reset <= 0;                                          @(posedge clock);
    for (i = 0; i < 10; ++i) begin
      @(posedge clock);
    end

    initial_distance <= 10'd360; initial_height <= 9'd120; initial_gap_height <= 9'd200;
    reset <= 1;                                          @(posedge clock);
    reset <= 0;                                          @(posedge clock);
    for (i = 0; i < 10; ++i) begin
      @(posedge clock);
    end

    initial_distance <= 10'd180; initial_height <= 9'd120; initial_gap_height <= 9'd240;
    reset <= 1;                                          @(posedge clock);
    reset <= 0;                                          @(posedge clock);
    for (i = 0; i < 10; ++i) begin
      @(posedge clock);
    end

    initial_distance <= 10'd0; initial_height <= 9'd120; initial_gap_height <= 9'd160;
    reset <= 1;                                          @(posedge clock);
    reset <= 0;                                          @(posedge clock);
    for (i = 0; i < 1280; ++i) begin
      @(posedge clock);
    end
    $stop;
  end
endmodule: Obstacle_testbench
