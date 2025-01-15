class sb_predictor extends uvm_subscriber#(my_transaction);
  `uvm_component_utils(sb_predictor)
  
  uvm_analysis_port#(my_transaction) results_ap;
  
  function new(string name,uvm_component parent);
    super.new(name, parent);
  endfunction
    
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    results_ap=new("results_ap", this);
  endfunction
    
  function void write(my_transaction t);
    my_transaction exp_tr;
    exp_tr=sb_calc_exp(t);
    results_ap.write(exp_tr);
  endfunction
    
  extern function my_transaction sb_calc_exp(my_transaction t);
endclass
    
function my_transaction sb_predictor::sb_calc_exp(my_transaction t);
  static bit [7:0] mem [15:0];
  my_transaction trans=my_transaction::type_id::create("my_trans");
  trans.copy(t);
  if(~trans.reset) begin
    if(trans.enable) begin
      mem [trans.addr]=trans.data_in;
    end
      
    else begin
      trans.data_out<=mem[trans.addr];
    end
    
  end
    
  else begin
    trans.data_out=trans.data_out;
  end
    
  return trans;
endfunction
