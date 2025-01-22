class uart_sw_monitor extends uvm_monitor;
	 `uvm_component_utils(uart_sw_monitor)

     virtual uart_sw_intf config_intf;
	 logic clk;
     uvm_analysis_port #(uart_sw_item) ap ;
	 uart_sw_item item;
     //define function
     extern function new(string name = "uart_sw_monitor", uvm_component parent = null);
     extern task run_phase(uvm_phase phase);
     extern function void build_phase(uvm_phase phase);
     extern function void connect_phase(uvm_phase phase);
     extern function void report_phase(uvm_phase phase);
     covergroup tx;
	 	START_TX : coverpoint config_intf.start_tx{}
		TX_DONE: coverpoint config_intf.tx_done{}
	 	DATA_TX : coverpoint config_intf.tx_data{}
	 endgroup
	covergroup rx;
	 	PARITY_ERROR : coverpoint config_intf.parity_error{}
		RX_DONE: coverpoint config_intf.rx_done{}
	 	DATA_RX : coverpoint config_intf.rx_data{}
	 endgroup
	covergroup config_mode;
	 	DATA_BIT_NUM : coverpoint config_intf.data_bit_num{}
		STOP_BIT_NUM: coverpoint config_intf.stop_bit_num{}
	 	PARITY_TYPE : coverpoint config_intf.parity_type{}
		PARITY_EN : coverpoint config_intf.parity_en{}
		CROSS_CHECK : cross config_intf.data_bit_num , config_intf.stop_bit_num ,config_intf.parity_type, config_intf.parity_en{}
	endgroup
	 task send_tx_data();
	 forever begin
	 	item = uart_sw_item::type_id::create("item");
	 		//fill not vao cho em Hung Kien
	 	@(posedge config_intf.tx_done )
		item.tx_data = config_intf.tx_data;
		//item.rx_data = config_intf.rx_data;
		if(config_intf.data_bit_num == 0) item.tx_data &= 8'b00011111 ; 
		if(config_intf.data_bit_num == 1) item.tx_data &= 8'b00111111  ;
		if(config_intf.data_bit_num == 2) begin
		item.tx_data &= 8'b01111111  ;
		//`uvm_info("sw_monitor",$sformatf("num 2 : %b",item.tx_data),UVM_MEDIUM)
		end
		if(config_intf.data_bit_num == 3) item.tx_data &= 8'b11111111;
		ap.write(item);
		`uvm_info("sw_monitor",$sformatf("tx done"),UVM_MEDIUM)
	 end
	 endtask
	 	task send_rx_data();
	 forever begin
	 	item = uart_sw_item::type_id::create("item");
	 		//fill not vao cho em Hung Kien
	 	@(posedge config_intf.rx_done )
		//item.tx_data = config_intf.tx_data;
		item.rx_data = config_intf.rx_data;
		// if(config_intf.data_bit_num == 0) item.tx_data &= 8'b00011111 ; 
		// if(config_intf.data_bit_num == 1) item.tx_data &= 8'b00111111  ;
		// if(config_intf.data_bit_num == 2) begin
		// item.tx_data &= 8'b01111111  ;
		// //`uvm_info("sw_monitor",$sformatf("num 2 : %b",item.tx_data),UVM_MEDIUM)
		// end
		// if(config_intf.data_bit_num == 3) item.tx_data &= 8'b11111111;
		ap.write(item);
		`uvm_info("sw_monitor",$sformatf("rx done"),UVM_MEDIUM)
	 end
	 endtask
	 task check_cover();
	 forever begin
	 	@(posedge config_intf.clk)
	 	tx.sample();
		rx.sample();
		config_mode.sample();
		//`uvm_info("sw_monitor",$sformatf("tx or rx done"),UVM_MEDIUM)
	 end
	 endtask
endclass: uart_sw_monitor

function uart_sw_monitor::new(string name = "uart_sw_monitor", uvm_component parent = null);
     super.new(name,parent);
	 tx = new();
	 rx = new();
	 config_mode = new();
endfunction

function void uart_sw_monitor::build_phase(uvm_phase phase);
		ap = new("ap",this);
		if (!uvm_config_db#(virtual uart_sw_intf)::get(this, "", "uart_sw_intf", config_intf))
      `uvm_fatal("DRV", "Could not get vif")
endfunction : build_phase

function void uart_sw_monitor::connect_phase(uvm_phase phase);
		//chua biet fill gi
endfunction : connect_phase

function void uart_sw_monitor::report_phase(uvm_phase phase);
		//chua biet fill gi
endfunction : report_phase

task uart_sw_monitor::run_phase(uvm_phase phase);
	// uart_sw_item item;
	@(posedge config_intf.reset_n)
	 forever begin 
		fork
			send_tx_data();
			send_rx_data();
			check_cover();
		join_any	
	 	//ap.write(item);
	 end
endtask : run_phase