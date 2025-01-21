class uart_rx_sequencer extends uvm_sequencer #(uart_rx_transaction);
	`uvm_component_utils(uart_rx_sequencer)
	extern function new(string name = "uart_rx_sequencer", uvm_component parent = null);
endclass : uart_rx_sequencer

function uart_rx_sequencer::new(string name = "uart_rx_sequencer", uvm_component parent = null);
     super.new(name,parent);
endfunction