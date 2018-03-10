/**
 * The bird flying through obstacles.
 *
 * Inputs:
 *   clock: The reference clock.
 *   reset: The reset signal.
 *   fly: Whether to fly.
 *
 * Outputs:
 *   height: The height of the bird above the ground.
 */
module Bird(clock, reset, fly, height);
  input logic clock, reset, fly;
  output logic [8:0] height;

  always_ff @(posedge clock) begin
    if (reset)
      height <= Constants::BIRD_DEFAULT_HEIGHT;
    else
      if (fly && height < Constants::BIRD_MAX_HEIGHT)
        height <= height + 9'b1;
      else if (!fly && Constants::BIRD_MIN_HEIGHT < height)
        height <= height - 9'b1;
  end
endmodule: Bird

/**
 * Testbench for the Bird module.
 */
module Bird_testbench();
  logic clock, reset, fly;
  logic [8:0] height;

  Bird dut(.clock, .reset, .fly, .height);

  parameter CLOCK_PERIOD = 100;
  initial begin
    clock <= 0;
    forever #(CLOCK_PERIOD / 2) clock <= ~clock;
  end

  integer i;
  initial begin
                          @(posedge clock);
    reset <= 1; fly <= 0; @(posedge clock);
    reset <= 0; fly <= 0; @(posedge clock);
    for (i = 0; i < 300; ++i) begin
      @(posedge clock);
    end

    fly <= 1;             @(posedge clock);
    fly <= 0;             @(posedge clock);
    fly <= 1;             @(posedge clock);
                          @(posedge clock);
                          @(posedge clock);
    fly <= 0;             @(posedge clock);
                          @(posedge clock);
    fly <= 1;             @(posedge clock);
    for (i = 0; i < 500; ++i) begin
      @(posedge clock);
    end
    $stop;
  end
endmodule: Bird_testbench
