class uart_tx_monitor extends uvm_monitor;
	 `uvm_component_utils(uart_tx_monitor)
    uart_tx_transaction item;
     virtual uart_tx_intf tx_if;
     virtual config_interface config_intf;
	 logic clk;
     uvm_analysis_port #(uart_tx_transaction) ap ;
	 //uart_sw_item item;
     logic[3:0] parity;

     realtime bit_time;
     //define function
     extern function new(string name = "uart_tx_monitor", uvm_component parent = null);
     extern task run_phase(uvm_phase phase);
     extern function void build_phase(uvm_phase phase);
     extern function void connect_phase(uvm_phase phase);
     extern function void report_phase(uvm_phase phase);
     
endclass: uart_tx_monitor

function uart_tx_monitor::new(string name = "uart_tx_monitor", uvm_component parent = null);
     super.new(name,parent);
endfunction

function void uart_tx_monitor::build_phase(uvm_phase phase);
    super.build_phase(phase);
		ap = new("ap",this);
		if (!uvm_config_db#(virtual uart_tx_intf)::get(this, "", "uart_tx_intf", tx_if))
      `uvm_fatal("monitor", "Could not get tx vif")
		if (!uvm_config_db#(virtual config_interface)::get(this, "", "config_interface", config_intf))
      `uvm_fatal("monitor", "Could not get config vif")
endfunction : build_phase

function void uart_tx_monitor::connect_phase(uvm_phase phase);
		//chua biet fill gi
endfunction : connect_phase

function void uart_tx_monitor::report_phase(uvm_phase phase);
		//chua biet fill gi
endfunction : report_phase

task uart_tx_monitor::run_phase(uvm_phase phase);

    item = uart_tx_transaction::type_id::create("item");
    bit_time = (50000000/115200);
    parity = 0;
	 forever begin
        `uvm_info("tx_monitor",$sformatf("before"),UVM_MEDIUM)
        //wait for start condition from tx
	  	@( negedge tx_if.tx);
	 	`uvm_info("tx_monitor",$sformatf("start_receive_vip"),UVM_MEDIUM)
        #(bit_time*10ns);
        #(bit_time*20ns);
        `uvm_info("tx_monitor",$sformatf("after_start"),UVM_MEDIUM)
        case(config_intf.data_bit_num)
          `DATA_5BIT: begin
               for(int i = 0; i < `DATA_FRAME_5BIT; i++) begin
                    parity += tx_if.tx;
                    item.data_frame[i] = tx_if.tx;
                    #(bit_time*20ns);
               end
          end
          `DATA_6BIT: begin
               for(int i = 0; i < `DATA_FRAME_6BIT; i++) begin
                    parity += tx_if.tx;
                    item.data_frame[i] = tx_if.tx;
                    #(bit_time*20ns);
               end
          end
          `DATA_7BIT: begin
               for(int i = 0; i < `DATA_FRAME_7BIT; i++) begin
                    parity += tx_if.tx;
                    item.data_frame[i] = tx_if.tx;
                    #(bit_time*20ns);
               end
          end
          `DATA_8BIT: begin
               for(int i = 0; i < `DATA_FRAME_8BIT; i++) begin
                    parity += tx_if.tx;
                    item.data_frame[i] = tx_if.tx;
                    #(bit_time*20ns);
               end
          end
        endcase
        ap.write(item);
        #(bit_time*20ns);
          `uvm_info("tx_monitor",$sformatf("transmited: %h",item.data_frame),UVM_MEDIUM)
     end
    //       if(config_intf.parity_en) begin
    //            parity += tx_if.tx;
    //            //`uvm_info("tx_monitor",$sformatf("parity_bit : %d " ,tx_if.tx),UVM_MEDIUM)
    //            if(config_intf.parity_type == `UART_PARITY_ODD) begin
    //                 `uvm_info("tx_monitor",$sformatf("parity_bit : %d " ,parity),UVM_MEDIUM)
    //                 if(parity[0] == 1) `uvm_info("tx_monitor",$sformatf("detect parity bit ODD "),UVM_MEDIUM)
    //                 else `uvm_error("tx_monitor","parity error")
    //            end
    //            else begin
    //                 if(parity[0] == 0) `uvm_info("tx_monitor",$sformatf("detect parity bit EVEN "),UVM_MEDIUM)
    //                 else `uvm_error("tx_monitor","parity error")
    //            end
    //            #(bit_time*20ns);
    //       end
    //       //stop condition
    //       if(config_intf.stop_bit_num == `UART_TWO_STOP_BIT) begin
    //            for(int i = 0 ; i < 2 ; i++) begin
    //                 if(tx_if.tx == 1 && i == 0) `uvm_info("tx_monitor",$sformatf("1 st bit detected"),UVM_MEDIUM)
    //                 else if (tx_if.tx == 1 && i == 1) `uvm_info("tx_monitor",$sformatf("2 st bit detected"),UVM_MEDIUM)
    //                      else `uvm_error("tx_monitor","stop bit error")
    //                 #(bit_time*20ns);
    //            end
    //       end
    //       else begin
    //       if (tx_if.tx == 1 ) `uvm_info("tx_monitor",$sformatf("stop bit detected"),UVM_MEDIUM)
    //            else `uvm_error("tx_monitor","stop bit error")
    //            #(bit_time*20ns);
    //       end
    //       parity = 0 ;
	//  		//fill not vao cho em Hung Kien
	//  end
	//  end
endtask : run_phase