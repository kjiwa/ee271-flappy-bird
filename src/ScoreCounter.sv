/**
 * A module that tracks the current score.
 *
 * The score is incremented if the bird passes an obstacle.
 *
 * Inputs:
 *   clock: The reference clock.
 *   reset: The reset signal.
 *   obs0_x_max: The max x value of obstacle 0.
 *   obs1_x_max: The max x value of obstacle 1.
 *   obs2_x_max: The max x value of obstacle 2.
 *   game_over: Whether the game is over.
 *
 * Outputs:
 *   score: The current score.
 */
module ScoreCounter(
    clock, reset,
    obs0_x_max, obs1_x_max, obs2_x_max,
    game_over,
    score);
  input logic clock, reset;
  input logic [9:0] obs0_x_max, obs1_x_max, obs2_x_max;
  input logic game_over;
  output logic [9:0] score;

  always_ff @(posedge clock) begin
    if (reset)
      score <= 10'd0;
    else if (!game_over
            && ((obs0_x_max == Constants::BIRD_VGA_X_MIN)
                || (obs1_x_max == Constants::BIRD_VGA_X_MIN)
                || (obs2_x_max == Constants::BIRD_VGA_X_MIN)))
      score <= score + 10'd1;
  end
endmodule: ScoreCounter

/**
 * Test bench for the ScoreCounter module.
 */
module ScoreCounter_testbench();
  logic clock, reset, game_over;
  logic [9:0] obs0_x_max, obs1_x_max, obs2_x_max, score;

  ScoreCounter dut(
      .clock, .reset, .obs0_x_max, .obs1_x_max, .obs2_x_max, .game_over,
      .score);

  parameter CLOCK_PERIOD = 100;
  initial begin
    clock <= 0;
    forever #(CLOCK_PERIOD / 2) clock <= ~clock;
  end

  initial begin
                @(posedge clock);

    obs0_x_max <= 10'd0; obs1_x_max <= 10'd0; obs2_x_max <= 10'd0;
    game_over <= 0;
    reset <= 1;                              @(posedge clock);
    reset <= 0;                              @(posedge clock);
                                             @(posedge clock);
    obs0_x_max <= Constants::BIRD_VGA_X_MIN; @(posedge clock);
    obs0_x_max <= 10'd0;                     @(posedge clock);
                                             @(posedge clock);
    obs1_x_max <= Constants::BIRD_VGA_X_MIN; @(posedge clock);
    obs1_x_max <= 10'd0;                     @(posedge clock);
                                             @(posedge clock);
    game_over <= 1;
    obs2_x_max <= Constants::BIRD_VGA_X_MIN; @(posedge clock);
    obs2_x_max <= 10'd0;                     @(posedge clock);
                                             @(posedge clock);

    $stop;
  end
endmodule: ScoreCounter_testbench
