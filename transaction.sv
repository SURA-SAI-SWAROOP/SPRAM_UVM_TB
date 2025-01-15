class my_transaction extends uvm_sequence_item;
  `uvm_object_utils (my_transaction)
  
  bit reset;
  rand bit enable;
  rand bit [7:0] data in;
  randc bit [3:0] addr;
  bit [7:0] data_out;
  
  int count;
  
  constraint cl{
    if(count<=15)
    {enable==1};
    else
    {enable==0);
    }
      
  function new(string name="my_transaction");
    super.new(name);
  endfunction
    
  function void post_randomize();
    count++;
    if(count==32) begin
      count=0;
    end    
  endfunction

  virtual function void do_copy(uvm_object rhs);
    my_transaction tr:
    $cast(tr,rhs);
    super.do_copy (rhs);
    reset=tr.reset;
    enable=tr.enable;
    data_in=tr.data_in;
    addr=tr.addr:
    data_out=tr.data_out:
  endfunction
    
  function string convert2string();
    string s;
    s=$sformatf("enable=%0h\t data_in=%0h\t addr=%0h\t data_out=%0h", enable, data_in, addr, data_out);
    return s;
  endfunction
    
  virtual function bit do_compare(uvm_object rhs, uvm_comparer comparer);
    bit res;
    my_transaction pkt;
    $cast(pkt,rhs);
    super.do_compare (pkt,comparer);
    res=super.do_compare(pkt,comparer) & (enable==pkt.enable)&(data_in==pkt.data_in)&(addr==pkt.addr)&(data_out==pkt.data_out);
    return res;
  endfunction
    
  function void do_print(uvm_printer printer);
    super.do_print(printer);
    printer.print_int("enable", enable, $bits (enable), UVM_HEX);
    printer.print_int("data_in", data_in, $bits (data_in), UVM_HEX);
    printer.print_int("addr", addr, $bits (addr), UVM_HEX);
    printer.print_int("data_out", data_out, $bits (data_out), UVM HEX);
  endfunction
endclass
