class uart_sw_driver extends uvm_driver #(uart_sw_item);
     `uvm_component_utils(uart_sw_driver)
     virtual uart_sw_intf config_intf;
     uart_sw_item item;
     int item_count = 0;
     
     extern function new(string name = "uart_sw_driver", uvm_component parent = null);
     extern task run_phase(uvm_phase phase);
     extern function void build_phase(uvm_phase phase);
     extern task drive();
     extern task check_reset();
     
endclass: uart_sw_driver

function uart_sw_driver::new(string name = "uart_sw_driver", uvm_component parent = null);
     super.new(name,parent);
endfunction

task uart_sw_driver::run_phase(uvm_phase phase);
//   forever begin
//     seq_item_port.get_next_item(item);
//     get_and_drive(item);
//     seq_item_port.item_done();
//   end
//`uvm_info("driver",$sformatf("hello chua biet fill gi"),UVM_MEDIUM)
     @(negedge config_intf.reset_n);
          config_intf.tx_data = 0;
          config_intf.data_bit_num = 0;
          config_intf.stop_bit_num = 0;

          config_intf.parity_en = 0;
          config_intf.parity_type = 0;
           config_intf.start_tx = 0;
          config_intf.rx_done = 0;
          config_intf.tx_done = 0;
          config_intf.rx_data = 0;
          config_intf.parity_error = 0;
          //config signal for reset //Kien
     `uvm_info("driver",$sformatf("start driver"),UVM_MEDIUM)
     // @(posedge config_intf.reset_n)
     // @(posedge config_intf.clk)
     //`uvm_info("driver",$sformatf("check_1"),UVM_MEDIUM)
     item =new;
     fork
          check_reset();
     join_none

     forever begin
          // while(~config_intf.reset_n)
          //      @(posedge config_intf.clk);
          //#200
               seq_item_port.get_next_item(item);
               item.print();
               `uvm_info("driver",$sformatf("bit_num = : %h",item.data_bit_num),UVM_MEDIUM)
               //repeat(item.delay_for_tran) @(posedge config_intf.clk);
               //drive_item(m_item);

          fork
               drive();
               check_reset();
          join_any
          disable fork;

          // without rsp
          //if(item)
          if(item.start_tx == 1) begin
          @(posedge config_intf.clk);
          @(posedge config_intf.tx_done);
          `uvm_info("driver",$sformatf("send_done = : %h",item.tx_data),UVM_MEDIUM)
          config_intf.start_tx = 0;
          end
          seq_item_port.item_done();
     end
endtask : run_phase

task uart_sw_driver::check_reset();
     // wait(~config_intf.reset_n)
     // //config for signal in reset //Kien
     // @(posedge config_intf.clk);
endtask

task uart_sw_driver::drive();
int current_idx = 0;
`uvm_info("drive_num_bit",$sformatf("bit_num = : %h",item.data_bit_num),UVM_MEDIUM)
// repeat (item.burst_len) begin
//      //idle
     // while(config_intf.reset_n == 1'b0) begin
     config_intf.tx_data = item.tx_data;
     config_intf.data_bit_num = item.data_bit_num;
     config_intf.stop_bit_num = item.stop_bit_num;
     config_intf.parity_en = item.parity_en;
     config_intf.parity_type = item.parity_type;
     config_intf.start_tx = item.start_tx;
     // @(posedge config_intf.clk )
      //@(posedge config_intf.clk )
     // @(posedge config_intf.clk )
     // @(posedge config_intf.clk )
     //config_intf.start_tx = 0 ;
     //`uvm_info("driver",$sformatf("checkkkk"),UVM_MEDIUM)
     //`uvm_info("intf",$sformatf("hello chua biet fill gi : %h",config_intf.tx_data),UVM_MEDIUM)
     //  @(posedge config_intf);
//  end
//      // send_data
     // config_intf.tx_data <= item. tx_data;
     // config_intf.rx_data <= item.rx_data;
//      //gan tien hieu can tuyen //Kien
//end 
endtask

function void uart_sw_driver::build_phase(uvm_phase phase);
    if (!uvm_config_db#(virtual uart_sw_intf)::get(this, "", "uart_sw_intf", config_intf))
      `uvm_fatal("DRV", "Could not get vif")
//chưa biet fill gi :)))
endfunction: build_phase