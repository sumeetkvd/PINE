// Design:

`timescale 1ns / 1ps

module fifo
(
 clk, reset, 
 buffer_in, buffer_out, 
 write_en, read_en, 
 buffer_empty, buffer_full
);

  
// Instialization of Inputs
input reset, clk, write_en, read_en;
input [7:0] buffer_in;
  

// Instialization of Outputs
output reg [7:0] buffer_out;
output reg buffer_empty, buffer_full;
  
  
// Instialization of Registers
reg [6:0] fifo_counter,read_ptr, write_ptr;
reg [7:0] buffer_mem [63:0];

integer i;
  
// Checking the condition of memory empty or full
always @(fifo_counter) begin
    buffer_empty = (fifo_counter == 0);
    buffer_full = (fifo_counter == 64);
   end

// After checking memory, here resetting of counter and the fifo memory   
  always @(posedge clk or posedge reset) begin
    if (reset) begin
        fifo_counter <= 7'b0000000;
      for (i=0; i<64; i=i+1) buffer_mem[i] <= 16'd0;
    end
    
    // Condition when read and write operation is starts at same time
    else if( (!buffer_full && write_en) && (!buffer_empty && read_en)) begin
        fifo_counter <= fifo_counter;
    end
    
    // Write operation in which we are checking if buffer is not full and write is enabled
    else if ( !buffer_full && write_en ) begin
        fifo_counter <= fifo_counter + 1;
    end
    
    // Read operation in which we are checking if buf is not empty and read is enabled
    else if ( !buffer_empty && read_en ) begin
        fifo_counter <= fifo_counter - 1;
    end
    else begin
        fifo_counter <= fifo_counter;
    end
    end
   
// Read operation    
  always @(posedge clk or posedge reset) begin
  if (reset) begin
        buffer_out <= 16'd0;
    end
    else begin
      if ( read_en && !buffer_empty ) begin
          buffer_out <= buffer_mem[read_ptr];
        end
        else begin
            buffer_out <= buffer_out;
        end
    end
end

// Write operation
always @(posedge clk) begin
    
  if ( write_en && !buffer_full ) begin
          buffer_mem[write_ptr] <= buffer_in;
        end
        else begin
          buffer_mem[write_ptr] <= buffer_mem[write_ptr];
        end
    
end

// Updating the write and read pointer
  always @(posedge clk or posedge reset) begin
    if (reset) begin
        write_ptr <= 7'd0;
        read_ptr <= 7'd0;
    end
    else begin
      if ( read_en && !buffer_empty ) begin
            read_ptr <= read_ptr + 1;
        end
        else begin
            read_ptr <= read_ptr;
        end
        
      if ( write_en && !buffer_full ) begin
                    write_ptr <= write_ptr + 1;
                end
                else begin
                    write_ptr <= write_ptr;
                end
    end
end

endmodule

// --------------------------------------------------------------------- //

// Testbench

// Code your testbench here
// or browse Examples


module testbench();
  
  reg reset, clk, write_en, read_en;
  reg [15:0] buffer_in;
  
  wire [15:0] buffer_out;
  wire buf_empty, buffer_full;
  
  fifo dut( .clk(clk), .reset(reset), .buffer_in(buffer_in), 
           .buffer_out(buffer_out),   .write_en(write_en), .read_en(read_en), .buffer_empty(buffer_empty), 
           .buffer_full(buffer_full));
  
  integer x;
  initial begin
    $dumpfile("dump.vcd"); $dumpvars;
    
    
    //fifo reset
    clk = 1'b0;
    reset = 1'b1;
    #10 reset = 1'b0;
    
    write_en = 1'b1;
    buffer_in = 16'hFFFF;
    #10 write_en = 1'b0;
    
    read_en = 1'b1;
    #10 read_en = 1'b0;
    
//    rst = 1'b1;
//    #10 rst = 1'b0;
    
    write_en = 1'b1;
    for (x=0; x<11; x=x+1) #10 buffer_in <= x;
    #10 write_en = 1'b0;
    
    read_en = 1'b1;
    #120 read_en = 1'b0;
    
    write_en = 1'b1;
    buffer_in = 16'hFFFF;
    #10 write_en = 1'b0;
    
    write_en = 1'b1;
    read_en = 1'b1;
    
    #20 read_en = 1'b0; write_en = 1'b0;
    reset = 1'b1;
    #10 reset = 1'b0;
    
    write_en = 1'b1;
    for (x=0; x<11; x=x+1) #10 buffer_in <= x;
    #10 write_en = 1'b0;
    
    read_en = 1'b1;
    #180 read_en = 1'b0;
    
    reset = 1'b1;
    #10 reset = 1'b0;
    
    $finish;
  end
  
  always #5 clk = ~clk;
  
endmodule
