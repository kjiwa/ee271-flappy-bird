/**
 * A D flip-flop, used to isolate input changes from changes between clock
 * cycles.
 *
 * Inputs:
 *   clock: The reference clock.
 *   reset: The reset signal.
 *   data: The input signal.
 *
 * Outputs:
 *   q: The buffered input.
 */
module DFlipFlop(clock, reset, data, q);
  input logic clock, reset, data;
  output logic q;

  always_ff @(posedge clock) begin
    if (reset)
      q <= 0;
    else
      q <= data;
  end
endmodule: DFlipFlop

/**
 * Test bench for the D flip flop.
 */
module DFlipFlop_testbench();
  logic clock, reset, data, q;

  DFlipFlop dut(.clock, .reset, .data, .q);

  parameter CLOCK_PERIOD = 100;
  initial begin
    clock <= 0;
    forever #(CLOCK_PERIOD / 2) clock = ~clock;
  end

  initial begin
                                                                @(posedge clock);
    reset <= 1;                                                 @(posedge clock);
    reset <= 0;                                                 @(posedge clock);
                                                                @(posedge clock);

    data <= 0;                                                  @(posedge clock);
    data <= 1;                                                  @(posedge clock);
    data <= 0;                                                  @(posedge clock);
                                                                @(posedge clock);

    $stop;
  end
endmodule: DFlipFlop_testbench
