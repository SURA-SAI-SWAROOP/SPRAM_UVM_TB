class base_test extends uvm_test;
`uvm_component_utils (base_test)
my_env env;
my_sequence seq:
function new(string name, uvm_component parent);
super.new(name, parent);
endfunction
virtual function void build_phase (uvm_phase phase); super.build_phase (phase);
env=my_env::type_id::create("env", this);
endfunction
virtual function void end_of_elaboration_phase (uvm_phase phase); super.end_of_elaboration_phase (phase);
uvm_top.print_topology();
endfunction
task run_phase (uvm_phase phase);
phase.raise_objection(this); seq=my_sequence:: type_id::create("seq"); seq.start(env.agnt.sqr);
phase.drop_objection(this);
endtask
endclass
