// Design

module Mux4to1(
  input [3:0] data,
  input [1:0] sel,
  output out
);

  wire w0, w1, w2, w3;

  and gate0(w0, data[0], ~sel[0], ~sel[1]);
  and gate1(w1, data[1], ~sel[0], sel[1]);
  and gate2(w2, data[2], sel[0], ~sel[1]);
  and gate3(w3, data[3], sel[0], sel[1]);

  or out(w0, w1, w2, w3, out);

endmodule


//------------------------------------------------------------------------------ //

module TestBench;

  reg [3:0] data;
  reg [1:0] sel;
  wire out;

  Mux4to1 mux(data, sel, out);

  initial begin
    // Test case 1: Select input 0 (sel = 2'b00)
    data = 4'b1010;
    sel = 2'b00;
    #10;
    $display("Output = %b", out);

    // Test case 2: Select input 1 (sel = 2'b01)
    data = 4'b1010;
    sel = 2'b01;
    #10;
    $display("Output = %b", out);

    // Test case 3: Select input 2 (sel = 2'b10)
    data = 4'b1010;
    sel = 2'b10;
    #10;
    $display("Output = %b", out);

    // Test case 4: Select input 3 (sel = 2'b11)
    data = 4'b1010;
    sel = 2'b11;
    #10;
    $display("Output = %b", out);

    // Add more test cases here...

    $finish;
  end

endmodule

