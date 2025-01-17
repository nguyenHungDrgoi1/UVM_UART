class uart_sw_sequencer extends uvm_sequencer #(uart_sw_item);
	`uvm_component_utils(uart_sw_sequencer)
	extern function new(string name = "uart_sw_sequencer", uvm_component parent = null);
endclass : uart_sw_sequencer

function uart_sw_sequencer::new(string name = "uart_sw_sequencer", uvm_component parent = null);
     super.new(name,parent);
endfunction