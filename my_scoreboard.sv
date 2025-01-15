class my_scoreboard extends uvm_scoreboard;
  `uvm_component_utils (my_scoreboard)
  
  uvm_analysis_export#(my_transaction) axp_in;
  sb_predictor prd;
  sb_comparator cmp;
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
    
  virtual function void build_phase(uvm_phase phase);
    super.build_phase (phase);
    axp_in=new("axp_in", this);
    prd=sb_predictor::type_id::create("prd", this);
    cmp=sb_comparator::type_id::create("cmp", this);
  endfunction
    
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    axp_in.connect(prd.analysis_export);
    axp_in.connect(cmp.axp_out);
    prd.results_ap.connect(cmp.axp_in);
  endfunction
endclass
