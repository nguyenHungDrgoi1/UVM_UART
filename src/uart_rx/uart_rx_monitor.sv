class uart_rx_monitor extends uvm_monitor;
	 `uvm_component_utils(uart_rx_monitor)
    uart_rx_transaction item;
     virtual uart_rx_intf rx_if;
     virtual config_interface config_intf;
	 logic clk;
     uvm_analysis_port #(uart_rx_transaction) ap ;
	 //uart_sw_item item;
     logic[3:0] parity;

     realtime bit_time;
     //define function
     extern function new(string name = "uart_rx_monitor", uvm_component parent = null);
     extern task run_phase(uvm_phase phase);
     extern function void build_phase(uvm_phase phase);
     extern function void connect_phase(uvm_phase phase);
     extern function void report_phase(uvm_phase phase);
     
endclass: uart_rx_monitor

function uart_rx_monitor::new(string name = "uart_rx_monitor", uvm_component parent = null);
     super.new(name,parent);
endfunction

function void uart_rx_monitor::build_phase(uvm_phase phase);
    super.build_phase(phase);
		ap = new("ap",this);
		if (!uvm_config_db#(virtual uart_rx_intf)::get(this, "", "uart_rx_intf", rx_if))
      `uvm_fatal("monitor", "Could not get rx vif")
		if (!uvm_config_db#(virtual config_interface)::get(this, "", "config_interface", config_intf))
      `uvm_fatal("monitor", "Could not get config vif")
endfunction : build_phase

function void uart_rx_monitor::connect_phase(uvm_phase phase);
		//chua biet fill gi
endfunction : connect_phase

function void uart_rx_monitor::report_phase(uvm_phase phase);
		//chua biet fill gi
endfunction : report_phase

task uart_rx_monitor::run_phase(uvm_phase phase);
	// uart_sw_item item;
    item = uart_rx_transaction::type_id::create("item");
    bit_time = (50000000/115200);
    parity = 0;
	 forever begin
        //wait for start condition from rx
         item.data_frame = 0;
	  	@(negedge rx_if.rx);
	 	`uvm_info("rx_monitor",$sformatf("start_receive"),UVM_MEDIUM)
        #(bit_time*10ns);
        #(bit_time*20ns);
        `uvm_info("rx_monitor",$sformatf("after_start"),UVM_MEDIUM)
        case(config_intf.data_bit_num)
          `DATA_5BIT: begin
               for(int i = 0; i < `DATA_FRAME_5BIT; i++) begin
                    parity += rx_if.rx;
                    item.data_frame[i] = rx_if.rx;
                    `uvm_info("rx_monitor",$sformatf("data_recive_debug: %h",item.data_frame),UVM_MEDIUM)
                    #(bit_time*20ns);
               end
          end
          `DATA_6BIT: begin
               for(int i = 0; i < `DATA_FRAME_6BIT; i++) begin
                    parity += rx_if.rx;
                    item.data_frame[i] = rx_if.rx;
                    #(bit_time*20ns);
               end
          end
          `DATA_7BIT: begin
               for(int i = 0; i < `DATA_FRAME_7BIT; i++) begin
                    parity += rx_if.rx;
                    item.data_frame[i] = rx_if.rx;
                    #(bit_time*20ns);
               end
          end
          `DATA_8BIT: begin
               for(int i = 0; i < `DATA_FRAME_8BIT; i++) begin
                    parity += rx_if.rx;
                    item.data_frame[i] = rx_if.rx;
                    #(bit_time*20ns);
               end
          end
        endcase
          `uvm_info("rx_monitor",$sformatf("data_recive: %h",item.data_frame),UVM_MEDIUM)
          if(config_intf.parity_en) begin
               parity += rx_if.rx;
               //`uvm_info("rx_monitor",$sformatf("parity_bit : %d " ,rx_if.rx),UVM_MEDIUM)
               if(config_intf.parity_type == `UART_PARITY_ODD) begin
                    `uvm_info("rx_monitor",$sformatf("parity_bit : %d " ,parity),UVM_MEDIUM)
                    if(parity[0] == 1) `uvm_info("rx_monitor",$sformatf("detect parity bit ODD "),UVM_MEDIUM)
                    else `uvm_error("rx_monitor","parity error")
               end
               else begin
                    if(parity[0] == 0) `uvm_info("rx_monitor",$sformatf("detect parity bit EVEN "),UVM_MEDIUM)
                    else `uvm_error("rx_monitor","parity error")
               end
               #(bit_time*20ns);
          end
          //stop condition
          if(config_intf.stop_bit_num == `UART_TWO_STOP_BIT) begin
               for(int i = 0 ; i < 2 ; i++) begin
                    if(rx_if.rx == 1 && i == 0) `uvm_info("rx_monitor",$sformatf("1 st bit detected"),UVM_MEDIUM)
                    else if (rx_if.rx == 1 && i == 1) `uvm_info("rx_monitor",$sformatf("2 st bit detected"),UVM_MEDIUM)
                         else `uvm_error("rx_monitor","stop bit error")
                    #(bit_time*20ns);
               end
          end
          else begin
          if (rx_if.rx == 1 ) `uvm_info("rx_monitor",$sformatf("stop bit detected"),UVM_MEDIUM)
               else `uvm_error("rx_monitor","stop bit error")
               #(bit_time*20ns);
          end
          parity = 0 ;
	 		//fill not vao cho em Hung Kien
               ap.write(item);
               #100
               ap.write(item);
	 end
	//  end
endtask : run_phase