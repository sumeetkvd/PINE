module CounterBase(
  input clk,
  output reg [7:0] count
);

  always @(posedge clk) begin
    count <= count + 1;
  end

endmodule

module UpCounter(
  input clk,
  output reg [7:0] count
);

  CounterBase counter(.clk(clk), .count(count));

endmodule

module DownCounter(
  input clk,
  output reg [7:0] count
);

  CounterBase counter(.clk(clk), .count(count));

  always @(posedge clk) begin
    count <= count - 1;
  end

endmodule

module TestBench;

  reg clk;
  reg reset;
  wire [7:0] count;

  always begin
    #5 clk = ~clk;
  end

  initial begin
    clk = 0;
    reset = 0;

    #20 reset = 1;

    #100 reset = 0;

    #200 $finish;
  end

  UpCounter upCounter(.clk(clk), .count(count));
  DownCounter downCounter(.clk(clk), .count(count));

  initial begin
    $monitor("Count: %d", count);
  end

endmodule
