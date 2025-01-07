`define MON_IF vif.mon_mod.MON

class my_monitor extends uvm_monitor;
  `uvm_component_utils (my_monitor)
  
  virtual my_if vif;
  my_transaction req;
  uvm_analysis_port#(my_transaction) mon_ap;
  
  function new(string name,uvm_component parent);
    super.new(name, parent);
  endfunction
    
  virtual function void build_phase (uvm_phase phase);
    mon_ap=new("mon_ap", this);
    super.build_phase (phase);
    if(!uvm_config_db#(virtual my_if)::get(this,"", "vif", vif))
      `uvm_fatal(get_type_name(), "VIF IS NOT SET PROPERLY")
  endfunction
      
  virtual task run_phase (uvm_phase phase);
    req=my_transaction:: type_id::create("req");
    forever begin
      monitor();
    end  
  endtask
    
  task monitor();
    @(`MON_IF);
    req.reset=MON_IF.reset;
    req.enable= MON_IF.enable;
    req.data_in= MON_IF.data_in;
    req.addr= MON_IF.addr;
    req.data_out= MON_IF.data_out;
    req.print();
    mon_ap.write(req);
  endtask
endclass
