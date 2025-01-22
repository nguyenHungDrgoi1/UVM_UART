class uart_tx_driver extends uvm_driver #(uart_tx_transaction);
     `uvm_component_utils(uart_tx_driver)
     virtual uart_tx_intf tx_if;
     uart_tx_transaction item;
    virtual config_interface config_intf;
     int item_count = 0;
    logic[3:0] parity;

     realtime bit_time;
     extern function new(string name = "uart_tx_driver", uvm_component parent = null);
     extern task run_phase(uvm_phase phase);
     extern function void build_phase(uvm_phase phase);
     extern task drive();
     extern task check_reset();
     
endclass: uart_tx_driver

function uart_tx_driver::new(string name = "uart_tx_driver", uvm_component parent = null);
     super.new(name,parent);
endfunction
function void uart_tx_driver::build_phase(uvm_phase phase);

    super.build_phase(phase);
		if (!uvm_config_db#(virtual uart_tx_intf)::get(this, "", "uart_tx_intf", tx_if))
      `uvm_fatal("monitor", "Could not get tx vif")
		if (!uvm_config_db#(virtual config_interface)::get(this, "", "config_interface", config_intf))
      `uvm_fatal("monitor", "Could not get config vif")
endfunction : build_phase
task uart_tx_driver::run_phase(uvm_phase phase);
   forever begin
     //item = uart_tx_transaction::type_id::create("item");
     item = new();
   seq_item_port.get_next_item(item);
   item.print();
//     get_and_drive(item);
     drive();
     seq_item_port.item_done();
   end
//`uvm_info("driver",$sformatf("hello chua biet fill gi"),UVM_MEDIUM)
    
endtask : run_phase

task uart_tx_driver::check_reset();
     // wait(~config_intf.reset_n)
     // //config for signal in reset //Kien
     // @(posedge config_intf.clk);
endtask

task uart_tx_driver::drive();
    bit_time = (50000000/115200);
    parity = 0;
    //int current_idx = 0;
       wait(tx_if.cts_n == 0)
        @(negedge tx_if.clk)
	 	`uvm_info("tx_driver",$sformatf("start_tx"),UVM_MEDIUM)
        //#(bit_time*10ns);
        //start_bit
        tx_if.tx = 0;
        #(bit_time*20ns);
        //`uvm_info("tx_monitor",$sformatf("after_start"),UVM_MEDIUM)
        case(config_intf.data_bit_num)
          `DATA_5BIT: begin
               for(int i = 0; i < `DATA_FRAME_5BIT; i++) begin
                    parity += tx_if.tx;
                    tx_if.tx = item.data_frame[i];
                    #(bit_time*20ns);
               end
          end
          `DATA_6BIT: begin
               for(int i = 0; i < `DATA_FRAME_6BIT; i++) begin
                    parity += tx_if.tx;
                    tx_if.tx = item.data_frame[i];
                    #(bit_time*20ns);
               end
          end
          `DATA_7BIT: begin
               for(int i = 0; i < `DATA_FRAME_7BIT; i++) begin
                    parity += tx_if.tx;
                    tx_if.tx = item.data_frame[i];
                    #(bit_time*20ns);
               end
          end
          `DATA_8BIT: begin
               for(int i = 0; i < `DATA_FRAME_8BIT; i++) begin
                    parity += tx_if.tx;
                    tx_if.tx = item.data_frame[i];
                    #(bit_time*20ns);
               end
          end
        endcase
          //`uvm_info("tx_monitor",$sformatf("data_recive: %h",item.data_frame),UVM_MEDIUM)
          if(config_intf.parity_en) begin
               parity += tx_if.tx;
               //`uvm_info("tx_monitor",$sformatf("parity_bit : %d " ,tx_if.tx),UVM_MEDIUM)
               if(config_intf.parity_type == `UART_PARITY_ODD) begin
                    //`uvm_info("tx_monitor",$sformatf("parity_bit : %d " ,parity),UVM_MEDIUM)
                    if(parity[0] == 1) begin
                         `uvm_info("tx_monitor",$sformatf("parity_bit : %d " ,parity),UVM_MEDIUM)
                        tx_if.tx = 0;
                    end
                    else begin
                        //`uvm_error("tx_monitor","parity error")
                        tx_if.tx = 1;
                    end
               end
               else begin
                    if(parity[0] == 0) //`uvm_info("tx_monitor",$sformatf("detect parity bit EVEN "),UVM_MEDIUM)
                    tx_if.tx = 0;
                    else tx_if.tx = 1;
                    //else `uvm_error("tx_driver","parity error")
               end
               #(bit_time*20ns);
          end
          //stop condition
          if(config_intf.stop_bit_num == `UART_TWO_STOP_BIT) begin
               for(int i = 0 ; i < 2 ; i++) begin
                tx_if.tx = 1;
                    // if(tx_if.tx == 1 && i == 0) `uvm_info("tx_monitor",$sformatf("1 st bit detected"),UVM_MEDIUM)
                    // else if (tx_if.tx == 1 && i == 1) `uvm_info("tx_monitor",$sformatf("2 st bit detected"),UVM_MEDIUM)
                    //      else `uvm_error("tx_monitor","stop bit error")
                    #(bit_time*20ns);
               end
          end
          else begin
                    tx_if.tx = 1;
                    // if(tx_if.tx == 1 && i == 0) `uvm_info("tx_monitor",$sformatf("1 st bit detected"),UVM_MEDIUM)
                    // else if (tx_if.tx == 1 && i == 1) `uvm_info("tx_monitor",$sformatf("2 st bit detected"),UVM_MEDIUM)
                    //      else `uvm_error("tx_monitor","stop bit error")
                    #(bit_time*20ns);
          //if (tx_if.tx == 1 ) //`uvm_info("tx_monitor",$sformatf("stop bit detected"),UVM_MEDIUM)
               //else `uvm_error("tx_monitor","stop bit error")
               //#(bit_time*20ns);
          end
          #(bit_time*200ns);
          `uvm_info("tx_driver",$sformatf("end_tx"),UVM_MEDIUM)
          parity = 0 ;
	 		//fill not vao cho em Hung Kien
endtask
