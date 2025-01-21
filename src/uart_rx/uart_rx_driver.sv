class uart_rx_driver extends uvm_driver #(uart_rx_transaction);
     `uvm_component_utils(uart_rx_driver)
     virtual uart_rx_intf rx_if;
     uart_rx_transaction item;
     int item_count = 0;
     
     extern function new(string name = "uart_rx_driver", uvm_component parent = null);
     extern task run_phase(uvm_phase phase);
     extern function void build_phase(uvm_phase phase);
     extern task drive();
     extern task check_reset();
     
endclass: uart_rx_driver

function uart_rx_driver::new(string name = "uart_rx_driver", uvm_component parent = null);
     super.new(name,parent);
endfunction

task uart_rx_driver::run_phase(uvm_phase phase);
//   forever begin
   seq_item_port.get_next_item(item);
//     get_and_drive(item);
     seq_item_port.item_done();
//   end
//`uvm_info("driver",$sformatf("hello chua biet fill gi"),UVM_MEDIUM)
    
endtask : run_phase

task uart_rx_driver::check_reset();
     // wait(~config_intf.reset_n)
     // //config for signal in reset //Kien
     // @(posedge config_intf.clk);
endtask

task uart_rx_driver::drive();
int current_idx = 0;
//`uvm_info("drive_func",$sformatf("tx_data = : %h",item.tx_data),UVM_MEDIUM)
// repeat (item.burst_len) begin
//      //idle
     // while(config_intf.reset_n == 1'b0) begin
    //  config_intf.tx_data = item.tx_data;
    //  config_intf.data_bit_num = item.data_bit_num;
    //  config_intf.stop_bit_num = item.stop_bit_num;
    //  config_intf.parity_en = item.parity_en;
    //  config_intf.parity_type = item.parity_type;
    //  config_intf.start_tx = item.start_tx;
     //`uvm_info("intf",$sformatf("hello chua biet fill gi : %h",config_intf.tx_data),UVM_MEDIUM)
     //  @(posedge config_intf);
//  end
//      // send_data
     // config_intf.tx_data <= item. tx_data;
     // config_intf.rx_data <= item.rx_data;
//      //gan tien hieu can tuyen //Kien
//end 
endtask

function void uart_rx_driver::build_phase(uvm_phase phase);
    if (!uvm_config_db#(virtual uart_rx_intf)::get(this, "", "uart_rx_intf", rx_if))
      `uvm_fatal("DRV_rx", "Could not get rx vif")
//chưa biet fill gi :)))
endfunction: build_phase