interface my_if (input clk, reset);
  logic enable;
  logic [7:0] data_in;
  logic [3:0]addr;
  logic [7:0] data_out;
  
  clocking DRV@(posedge clk);
    default input #1 output #1;
    output enable, data_in, addr;
    input data_out;
  endclocking
    
  clocking MON@(posedge clk);
    default input #1 output #1;
    input enable, data_in, addr, data_out;
    input reset;
  endclocking
    
  modport drv mod(clocking DRV, input clk, reset);
    modport mon_mod(clocking MON, input clk);
endinterface
