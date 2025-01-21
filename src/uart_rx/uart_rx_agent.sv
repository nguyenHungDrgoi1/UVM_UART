class uart_rx_agent extends uvm_agent;
	`uvm_component_utils(uart_rx_agent)

	//component instance
	uart_rx_driver driver;
	uart_rx_monitor monitor;
	uart_rx_sequencer sequencer;

	//function define
	extern function new(string name = "uart_rx_agent", uvm_component parent = null);
    extern function void build_phase(uvm_phase phase);
    extern function void connect_phase(uvm_phase phase);
endclass : uart_rx_agent

function uart_rx_agent::new(string name = "uart_rx_agent", uvm_component parent = null);
     super.new(name,parent);
endfunction

function void uart_rx_agent::build_phase(uvm_phase phase);
	super.build_phase(phase);
	//define
	driver = uart_rx_driver::type_id::create("driver",this);
	monitor = uart_rx_monitor::type_id::create("monitor",this);
	sequencer = uart_rx_sequencer::type_id::create("sequencer",this);
	// co the co config
	//chua co connect voi env
endfunction : build_phase

function void uart_rx_agent::connect_phase(uvm_phase phase);
	// co the them config
	driver.seq_item_port.connect(sequencer.seq_item_export);
endfunction : connect_phase
