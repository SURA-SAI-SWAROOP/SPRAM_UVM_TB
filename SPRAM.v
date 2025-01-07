module spram(
  input clk, reset,
  input enable,
  input [7:0] data_in,
  input [3:0] addr,
  output reg [7:0] data_out
);
  
  reg [7:0] mem [15:0];
  integer i;
  
  always@(posedge clk) begin
    if (reset) begin
      for(i=0;i<16;i++) begin
        mem[i]=8'b0000_0000;
      end
      
    end
      
    else begin
      if (enable) begin
        mem [addr]<=data_in;
      end
        
      else begin
        data_out<=mem[addr];
      end
      
    end
    
  end
endmodule
