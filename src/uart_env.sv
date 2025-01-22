class uart_env extends uvm_env;
	`uvm_component_utils(uart_env)

	//define instance
	uart_sw_agent	sw_agent;
	uart_rx_agent	rx_agent;
	uart_tx_agent	tx_agent;
	uart_scoreboard uart_sb;
	//define function
	 extern function new(string name = "uart_env", uvm_component parent = null);
     extern function void connect_phase(uvm_phase phase);
     extern function void build_phase(uvm_phase phase);
endclass

function uart_env::new(string name = "uart_env", uvm_component parent = null);
     super.new(name,parent);
endfunction

function void uart_env::build_phase(uvm_phase phase);
	super.build_phase(phase);
	//define
	sw_agent = uart_sw_agent::type_id::create("sw_agent",this);
	rx_agent = uart_rx_agent::type_id::create("rx_agent",this);
	tx_agent = uart_tx_agent::type_id::create("tx_agent",this);
	uart_sb = uart_scoreboard::type_id::create("uart_sb",this);
	//sw_agent.print();
	// co the co config
	//chua co connect voi env
endfunction : build_phase


 function void uart_env::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    //a0.m0.mon_analysis_port.connect(sb0.m_analysis_imp);
	sw_agent.monitor.ap.connect(uart_sb.analysis_imp_sw.analysis_export);
	rx_agent.monitor.ap.connect(uart_sb.analysis_imp_rx.analysis_export);
	tx_agent.monitor.ap.connect(uart_sb.analysis_imp_tx.analysis_export);
  endfunction :connect_phase