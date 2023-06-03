// Design

module HalfSubtractor(
  input a,
  input b,
  output diff,
  output borrow
);

  wire w1, w2;

  xor xorGate(diff, a, b);
  and andGate(w1, ~a, b);
  not notGate(w2, a);
  and borrow(w2, w1, w2);

endmodule

// --------------------------------------------------------------- //

// Testbench

module TestBench;

  reg a, b;
  wire diff, borrow;

  HalfSubtractor sub(a, b, diff, borrow);

  initial begin
    // Test case 1: a = 0, b = 0
    a = 0;
    b = 0;
    #10;
    $display("Difference = %b, Borrow = %b", diff, borrow);

    // Test case 2: a = 0, b = 1
    a = 0;
    b = 1;
    #10;
    $display("Difference = %b, Borrow = %b", diff, borrow);

    // Test case 3: a = 1, b = 0
    a = 1;
    b = 0;
    #10;
    $display("Difference = %b, Borrow = %b", diff, borrow);

    // Test case 4: a = 1, b = 1
    a = 1;
    b = 1;
    #10;
    $display("Difference = %b, Borrow = %b", diff, borrow);

    $finish;
  end

endmodule

