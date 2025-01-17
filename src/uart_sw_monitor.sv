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
     
endclass: uart_sw_monitor

function uart_sw_monitor::new(string name = "uart_sw_monitor", uvm_component parent = null);
     super.new(name,parent);
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
	 forever begin
	  	@(posedge config_intf.reset_n) begin
	 	item = uart_sw_item::type_id::create("item");
	 	item.tx_data = config_intf.tx_data;
	 		//fill not vao cho em Hung Kien
		end
	`uvm_info("sw_monitor",$sformatf("monitor_check_reset"),UVM_MEDIUM)
	 if(config_intf.start_tx == 1) begin
		`uvm_info("sw_monitor",$sformatf("tx_data: %h",config_intf.tx_data),UVM_MEDIUM)
	 end
	 end
	// 	ap.write(item);
	//  end
endtask : run_phase