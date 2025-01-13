class uart_sw_driver extends uvm_driver #(uart_sw_item);
     `uvm_component_utils(dti_apb_master_driver)
     virtual uart_sw_intf config_intf;
     uart_sw_item item;
     int item_count = 0;
     
     extern function new(sting name = "uart_sw_driver", uvm_component parent = null);
     extern task run_phase(uvm_phase phase);
     extern function void build_phase(uvm_phase phase);

     extern task drive();
     extern task check_reset();
     
endclass: uart_sw_driver

function uart_sw_driver::new(sting name = "uart_sw_driver", uvm_component parent = null);
     super.new(name,parent);
endfunction

task uart_sw_driver::run_phase(uvm_phase phase);

     @(negedge config_intf.reset_n);
          config_intf.tx_data <= 0;
          config_intf.data_bit_num <= 0;
          config_intf.stop_bit_num <= 0;
          config_intf.parity_en <= 0;
          config_intf.parity_type <= 0;
          config_intf.start_tx <= 0;
          config_intf.rx_done <= 0;
          config_intf.tx_done <= 0;
          config_intf.rx_data <= 0;
          config_intf.parity_error <= 0;
     @(posedge config_intf.reset_n)
     @(posedge config_intf.clk)
     item =new;
     fork
          check_reset();
     join_none

     forever begin
          while(~config_intf.reset_n)
               @(posedge config_intf.clk);
               seq_item_port.get_next_item(item);

          fork
               drive();
               check_reset();
          join_any
          disable fork;

          // without rsp
          //if(item)

          seq_item_port.item_done();
     end
endtask : run_phase

task uart_sw_driver::check_reset();
     wait(~config_intf.reset_n)
          config_intf.tx_data <= 0;
          config_intf.data_bit_num <= 0;
          config_intf.stop_bit_num <= 0;
          config_intf.parity_en <= 0;
          config_intf.parity_type <= 0;
          config_intf.start_tx <= 0;
          config_intf.rx_done <= 0;
          config_intf.tx_done <= 0;
          config_intf.rx_data <= 0;
          config_intf.parity_error <= 0;
     @(posedge config.clk);
endtask

task uart_sw_driver::drive();
int current_idx = 0;
'uvm_infor("config_uart",$sformatf("hello chua biet fill gi"),UVM_MEDIUM)
repeat (item.burst_len) begin
     //idle
     while(config_intf.reset = 1'b0) begin
      @(posedge config_intf)
     end
     // send_data
     config_intf.rx <= item.rx;
     config_intf.cts_n <= item.cts_n;
     config_intf.tx_data <= item.tx_data;
     config_intf.data_bit_num <= item.data_bit_num;
     config_intf.stop_bit_num <= item.stop_bit_num;
     config_intf.parity_en <= item.parity_en;
     config_intf.parity_type <= item.parity_type;
     config_intf.start_tx <= item.start_tx;
end 
endtask

function void uart_sw_driver::build_phase(uvm_phase phase)

//chưa biet fill gi :)))
endfunction: build_phase