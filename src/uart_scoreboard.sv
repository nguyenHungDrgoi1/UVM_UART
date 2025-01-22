class uart_scoreboard extends uvm_scoreboard;
`uvm_component_utils(uart_scoreboard)
  uart_rx_transaction item_rx_q[$];
  uart_tx_transaction item_tx_q[$];
  uart_sw_item item_sw_q[$];

  uvm_tlm_analysis_fifo #(uart_rx_transaction) analysis_imp_rx;
  uvm_tlm_analysis_fifo #(uart_tx_transaction) analysis_imp_tx;
  uvm_tlm_analysis_fifo #(uart_sw_item) analysis_imp_sw;
   function new(string name = "uart_scoreboard", uvm_component parent = null);
     super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
    // if (!uvm_config_db#(virtual uart_sw_intf)::get(this, "", "uart_sw_intf", config_intf))
    //   `uvm_fatal("DRV", "Could not get vif")
    super.build_phase(phase);
    analysis_imp_rx = new("analysis_imp_rx",this);
    analysis_imp_tx = new("analysis_imp_tx",this);
    analysis_imp_sw = new("analysis_imp_sw",this);
//chưa biet fill gi :)))
endfunction
//  virtual function void write (uart_rx_transaction item_rx_q,uart_tx_transaction item_tx_q,uart_sw_item item_sw_q);
//       item_rx_q.print();
//    endfunction 
task rx_check();
uart_rx_transaction item_rx;
uart_sw_item item_sw;
    analysis_imp_rx.get(item_rx);
    analysis_imp_sw.get(item_sw);
    //item_rx.print();
    //item_sw.print();
    if(item_rx.data_frame == item_sw.tx_data) `uvm_info("scoreboard",$sformatf("rx check for dut true %h",item_rx.data_frame),UVM_MEDIUM)
    else `uvm_error("scoreboard",$sformatf("data mismatch data_frame : %h rx_data : %h",item_rx.data_frame ,item_sw.tx_data))
    //`uvm_info("scoreboard",$sformatf("item_tx check "),UVM_MEDIUM)
//`uvm_info("scoreboard",$sformatf("item_rx check "),UVM_MEDIUM)
endtask

task tx_check();
uart_tx_transaction item_tx;
uart_sw_item item_sw;
    analysis_imp_tx.get(item_tx);
    analysis_imp_sw.get(item_sw);
    item_tx.print();
    item_sw.print();
    if(item_tx.data_frame == item_sw.rx_data) `uvm_info("scoreboard",$sformatf("rx check for dut true"),UVM_MEDIUM)
    else `uvm_error("scoreboard",$sformatf("data mismatch data_frame : %h rx_data : %h",item_tx.data_frame ,item_sw.rx_data))
//`uvm_info("scoreboard",$sformatf("item_tx check "),UVM_MEDIUM)
endtask

task run_phase(uvm_phase phase);

  uart_tx_transaction item_tx;
   uart_sw_item item_sw;
   `uvm_info("scoreboard",$sformatf("check "),UVM_MEDIUM)
   forever begin
//     wait(item_rx_q.size() > 0 && item_tx_q.size() > 0 && item_sw_q.size() > 0  );
//     item_rx = item_rx_q.pop_front();
//     item_tx = item_tx_q.pop_front();
//     item_sw = item_sw_q.pop_front();
//     item_rx.print();
//   end
    fork 
        rx_check();
        tx_check();
    //`uvm_info("scoreboard",$sformatf("check_2"),UVM_MEDIUM)
   // item_rx.print();
    join_any
    //disable fork;
    end
endtask
endclass