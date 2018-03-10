/**
 * A module that checks if the game is over.
 *
 * Inputs:
 *   clock: The reference clock;
 *   reset: The reset signal.
 *   collision: Whether a collision has occurred.
 *
 * Outputs:
 *   game_over: Whether the game is over.
 */
module GameStateTracker(clock, reset, collision, game_over);
  input logic clock, reset, collision;
  output logic game_over;

  typedef enum {
    RUNNING,
    OVER
  } State;

  State ns;
  always_comb begin
    if (collision)
      ns = OVER;
    else
      ns = RUNNING;
  end

  always_ff @(posedge clock) begin
    if (reset)
      game_over <= 1'b0;
    else if (ns == OVER)
      game_over <= 1'b1;
  end
endmodule: GameStateTracker

/**
 * Test bench for the GameStateTracker module.
 */
module GameStateTracker_testbench();
  logic clock, reset, collision, game_over;

  GameStateTracker dut(.clock, .reset, .collision, .game_over);

  parameter CLOCK_PERIOD = 100;
  initial begin
    clock <= 0;
    forever #(CLOCK_PERIOD / 2) clock <= ~clock;
  end

  initial begin
                                @(posedge clock);
    reset <= 1; collision <= 0; @(posedge clock);
    reset <= 0;                 @(posedge clock);
                                @(posedge clock);
    collision <= 1;             @(posedge clock);
                                @(posedge clock);
    collision <= 0;             @(posedge clock);
                                @(posedge clock);

    $stop;
  end
endmodule: GameStateTracker_testbench
