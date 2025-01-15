class my_env extends uvm_env;
  `uvm_component_utils(my_env)
  
  my_agent agnt;
  my_scoreboard scb;
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
    
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agnt=my_agent::type_id::create("agnt", this);
    scb=my_scoreboard:: type_id::create("scb", this);
  endfunction
    
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    agnt.mon.mon_ap.connect(scb.axp_in);
  endfunction
endclass
