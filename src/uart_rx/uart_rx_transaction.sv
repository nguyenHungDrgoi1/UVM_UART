class uart_rx_transaction extends uvm_sequence_item;
    uart_data_frame data_frame;
    bit parity_error;
    bit stop_error;
      `uvm_object_utils_begin(uart_rx_transaction)
    `uvm_field_int ( data_frame, UVM_ALL_ON)
  `uvm_object_utils_end
    extern function new(string name = "uart_rx_transaction");
endclass
function uart_rx_transaction::new(string name="uart_rx_transaction");  
  super.new(name);
endfunction