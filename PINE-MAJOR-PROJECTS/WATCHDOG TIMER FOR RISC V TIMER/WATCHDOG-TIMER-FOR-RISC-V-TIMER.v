// Design:

// Code your design here

module timer_programmable_atmega32 (
  input clk,
  input reset,
  input start,
  input stop,
  input [31:0] load,
  input [31:0] preload,
  output reg timeout
);

reg [31:0] counter;

  always @(negedge clk) begin
  if (reset) begin
    counter <= preload;
    timeout <= 1'b0;
  end else begin
    if (start) begin
      counter <= preload;
      timeout <= 1'b0;
    end else if (counter == load) begin
      timeout <= 1'b1;
    end else if (stop) begin
      counter <= preload;
      timeout <= 1'b0;
    end else begin
      counter <= counter + 1'b1;
    end
  end
end

endmodule

// ------------------------------------------------------------- //

// Testbench

// Code your testbench here
// or browse Examples

module timer_programmable_atmega32_tb;

reg clk;
reg reset;
reg start;
reg stop;
wire timeout;
reg [31:0] load;
reg [31:0] preload;

timer_programmable_atmega32 uut (
  .clk(clk),
  .reset(reset),
  .start(start),
  .stop(stop),
  .load(load),
  .preload(preload),
  .timeout(timeout)
);

initial begin
  $dumpfile("dump.vcd"); 
  $dumpvars;
  clk = 0;
  reset = 1;
  start = 0;
  stop = 0;
  load = 32'hFFFF_FFFF;
  preload = 32'h0000_0000;
  #10 reset = 0;
  #100 start = 1;
  #100 start = 0;
  #100 stop = 1;
  #100 stop = 0;
  #100 $finish;
end

always #5 clk = ~clk;

endmodule