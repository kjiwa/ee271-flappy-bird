/**
 * A nine-bit linear feedback shift register, to be used as a random number
 * generator.
 *
 * Inputs:
 *   clock: The reference clock.
 *   reset: The reset signal.
 *
 * Outputs:
 *   q: The random number.
 */
module NineBitLinearFeedbackShiftRegister(clock, reset, q);
  input logic clock, reset;
  output logic [8:0] q;

  logic feedback;
  assign feedback = ~(q[8] ^ q[4]);

  always_ff @(posedge clock) begin
    if (reset)
      q <= 9'b000000000;
    else
      q <= {q[7], q[6], q[5], q[4], q[3], q[2], q[1], q[0], feedback};
  end
endmodule: NineBitLinearFeedbackShiftRegister

/**
 * Test bench for the Nine-bit linear feedback shift register.
 */
module NineBitLinearFeedbackShiftRegister_testbench();
  logic clock, reset;
  logic [8:0] q;

  NineBitLinearFeedbackShiftRegister dut(.clock, .reset, .q);

  parameter CLOCK_PERIOD = 100;
  initial begin
    clock <= 0;
    forever #(CLOCK_PERIOD / 2) clock <= ~clock;
  end

  integer i;
  initial begin
                @(posedge clock);
    reset <= 1; @(posedge clock);
    reset <= 0; @(posedge clock);
    for (i = 0; i < 100; ++i)
      @(posedge clock);
    $stop;
  end
endmodule: NineBitLinearFeedbackShiftRegister_testbench
