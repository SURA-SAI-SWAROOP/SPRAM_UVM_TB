class sb_comparator extends uvm_component;
  `uvm_component_utils(sb_comparator)
  
  uvm_analysis_export#(my_transaction) axp_in;
  uvm_analysis_export#(my_transaction) axp_out;
  uvm_tlm_analysis_fifo#(my_transaction) expfifo;
  uvm_tlm_analysis_fifo#(my_transaction) outfifo;
  
  function new(string name,uvm_component parent);
    super.new(name,parent);
  endfunction
    
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    axp_in=new("axp_in", this);
    axp_out=new("axp_out", this);
    expfifo=new("expfifo", this);
    outfifo=new("outfifo", this);
  endfunction
    
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    axp_in.connect(expfifo.analysis_export);
    axp_out.connect(outfifo.analysis_export);
  endfunction
    
  task run_phase(uvm_phase phase);
    my_transaction exp_tr, out_tr;
    forever begin
      `uvm_info("sb_comparator run task", "Waiting for expected output", UVM_DEBUG)
      expfifo.get(exp_tr);
      `uvm_info("sb_comparator run task", "Waiting for actual output", UVM_DEBUG)
      outfifo.get(out_tr);
      if(out_tr.compare(exp_tr)) begin
        PASS();
        `uvm_info("PASS", $sformatf("Actual:: %s\t Expected::%s \n",out_tr.convert2string(),exp_tr.convert2string()),UVM_LOW)
      end
        
      else begin
        ERROR();
        `uvm_info("ERROR", $sformatf("Actual::%s\t Expected::%s \n",out_tr.convert2string(),exp_tr.convert2string()),UVM_LOW);
      end
      
    end
      
  endtask
    
  int VECT_CNT,PASS_CNT,ERROR_CNT;
  
  virtual function void report_phase(uvm phase phase);
    super.report phase (phase);
    if(VECT_CNT && !ERROR_CNT)
      `uvm_info(get_type_name(), $sformatf("\n\n\n***TEST PASSED::%Od VECTORS RAN, %0d VECTORS PASSED***\n", VECT_CNT, PASS_CNT), UVM_LOW)
      else
        `uvm_info(get_type_name(),$sformatf("\n\n\n***TEST FAILED::%0d VECTORS RAN, %0d VECTORS PASSED, %0d VECTORS FAILED",VECT_CNT,PASS_CNT,ERROR_CNT),UVM_LOW)
  endfunction
        
  function void PASS();
    VECT CNT++;
    PASS_CNT++;
  endfunction
    
  function void ERROR();
    VECT CNT++:
    ERROR_CNT++;
  endfunction
endclass
