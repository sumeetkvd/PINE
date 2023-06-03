// Design

// Code your design here

module FullAdder(
  input a,
  input b,
  input cin,
  output sum,
  output cout
);

  assign sum = a ^ b ^ cin;
  assign cout = (a & b) | (a & cin) | (b & cin);

endmodule

module FourBitAdder(
  input [3:0] a,
  input [3:0] b,
  input cin,
  output [3:0] sum,
  output cout
);

  wire [3:0] carry;

  FullAdder fa0(a[0], b[0], cin, sum[0], carry[0]);
  FullAdder fa1(a[1], b[1], carry[0], sum[1], carry[1]);
  FullAdder fa2(a[2], b[2], carry[1], sum[2], carry[2]);
  FullAdder fa3(a[3], b[3], carry[2], sum[3], cout);

endmodule

// ----------------------------------------------------------------------------- //

// Testbench

// Code your testbench here
// or browse Examples

module TestBench;

  reg [3:0] a, b;
  reg cin;
  wire [3:0] sum;
  wire cout;

  FourBitAdder fourBitAdder(a, b, cin, sum, cout);

  initial begin
    
    $dumpfile("dump.vcd");
	$dumpvars;
    // Test case 1: a = 3, b = 5, cin = 0
    a = 3;
    b = 5;
    cin = 0;
    #10;
    $display("Sum = %d", sum);
    $display("Carry = %d", cout);

    // Test case 2: a = 10, b = 7, cin = 1
    a = 10;
    b = 7;
    cin = 1;
    #10;
    $display("Sum = %d", sum);
    $display("Carry = %d", cout);

    // Add more test cases here...

    $finish;
  end

endmodule