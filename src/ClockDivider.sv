/**
 * A clock divider. Used to process actions at a slower rate than the reference
 * clock.
 *
 * Inputs:
 *   clock: The reference clock.
 *   reset: The reset signal.
 *
 * Outputs:
 *   dividedClocks: A bit array that can be used to access lower clock rates.
 */
module ClockDivider(clock, reset, dividedClocks);
  input logic clock, reset;
  output logic [31:0] dividedClocks;

  always_ff @(posedge clock) begin
    if (reset)
      dividedClocks <= 0;
    else
      dividedClocks <= dividedClocks + 1;
  end
endmodule: ClockDivider
