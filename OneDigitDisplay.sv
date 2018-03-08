/**
 * A module that handles displaying numbers on a seven-segment display.
 *
 * Inputs:
 *   value: A four-bit unsigned integer to be displayed.
 *
 * Outputs:
 *   hex: The output to display on a seven-segment display.
 */
module OneDigitDisplay(value, hex);
  input logic [3:0] value;
  output logic [6:0] hex;

  always_comb begin
    case (value)
      0: hex = ~7'b0111111;
      1: hex = ~7'b0000110;
      2: hex = ~7'b1011011;
      3: hex = ~7'b1001111;
      4: hex = ~7'b1100110;
      5: hex = ~7'b1101101;
      6: hex = ~7'b1111101;
      7: hex = ~7'b0000111;
      8: hex = ~7'b1111111;
      9: hex = ~7'b1101111;
      default: hex = 7'bX;
    endcase
  end
endmodule: OneDigitDisplay

/**
 * Test bench for the one-segment display.
 */
module OneDigitDisplay_testbench();
  logic [3:0] value;
  logic [6:0] hex;

  OneDigitDisplay dut(.value, .hex);
  integer i;
  initial begin
    for (i = 0; i < 16; ++i) begin
      value = i; #10;
    end
  end
endmodule: OneDigitDisplay_testbench
