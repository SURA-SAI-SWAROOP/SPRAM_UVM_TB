class my_sequence extends uvm_sequence#(my_transaction);
`uvm_object_utils (my_sequence)
function new(string name="my_sequence");
super.new(name);
endfunction
task body();
my_transaction req;
req=my_transaction:: type_id::create("req");
repeat (32) begin
start_item(req);
assert(req.randomize());
finish_item(req);
end
endtask
endclass
